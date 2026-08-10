import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_remote_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_dto.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/sync_queue_item.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/sync/domain/policies/sync_backoff_policy.dart';
import 'package:inspetorsys/features/sync/domain/services/inspection_sync_service.dart';
import 'package:mocktail/mocktail.dart';

class MockSyncQueueLocalDataSource extends Mock
    implements SyncQueueLocalDataSource {}

class MockInspectionLocalDataSource extends Mock
    implements InspectionLocalDataSource {}

class MockInspectionRemoteDataSource extends Mock
    implements InspectionRemoteDataSource {}

const clientId = 'client-123';
const queueId = 1;

final pendingInspection = Inspection(
  clientId: clientId,
  workOrderId: 'wo_1001',
  status: InspectionSyncStatus.pending,
  notes: 'Observação válida para envio',
  photoPath: '/tmp/photo.jpg',
  latitude: -7.1195,
  longitude: -34.845,
  formData: const {'condition': 'bom'},
  createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
  updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
);

final queueItem = SyncQueueItem(
  id: queueId,
  inspectionClientId: clientId,
  status: 'pending',
  retryCount: 0,
);

final uploadedDto = InspectionDto(
  id: 'insp_1',
  clientId: clientId,
  workOrderId: 'wo_1001',
  notes: 'Observação válida para envio',
  condition: 'bom',
  photoUrl: '/uploads/photo.jpg',
  latitude: -7.1195,
  longitude: -34.845,
  capturedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
  syncedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
);

void main() {
  late MockSyncQueueLocalDataSource syncQueueDataSource;
  late MockInspectionLocalDataSource inspectionLocalDataSource;
  late MockInspectionRemoteDataSource inspectionRemoteDataSource;
  late InspectionSyncService service;

  setUpAll(() {
    registerFallbackValue(pendingInspection);
    registerFallbackValue(DateTime.parse('2026-07-26T12:00:00.000Z'));
  });

  setUp(() {
    syncQueueDataSource = MockSyncQueueLocalDataSource();
    inspectionLocalDataSource = MockInspectionLocalDataSource();
    inspectionRemoteDataSource = MockInspectionRemoteDataSource();

    service = InspectionSyncService(
      syncQueueDataSource,
      inspectionLocalDataSource,
      inspectionRemoteDataSource,
    );
  });

  test('syncs pending inspection and saves serverId and syncedAt', () async {
    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [queueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer((_) async => pendingInspection);
    when(() => inspectionRemoteDataSource.uploadInspection(pendingInspection))
        .thenAnswer((_) async => uploadedDto);
    when(() => inspectionLocalDataSource.upsert(any()))
        .thenAnswer((_) async {});
    when(() => syncQueueDataSource.removeById(queueId))
        .thenAnswer((_) async {});

    final result = await service.processQueue();

    expect(result.synced, 1);

    final captured = verify(
      () => inspectionLocalDataSource.upsert(captureAny()),
    ).captured.single as Inspection;

    expect(captured.status, InspectionSyncStatus.synced);
    expect(captured.serverId, 'insp_1');
    expect(captured.syncedAt, uploadedDto.syncedAt);
    verify(() => syncQueueDataSource.removeById(queueId)).called(1);
  });

  test('reuses same clientId on upload for idempotent retry', () async {
    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [queueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer((_) async => pendingInspection);
    when(() => inspectionRemoteDataSource.uploadInspection(any()))
        .thenAnswer((_) async => uploadedDto);
    when(() => inspectionLocalDataSource.upsert(any()))
        .thenAnswer((_) async {});
    when(() => syncQueueDataSource.removeById(queueId))
        .thenAnswer((_) async {});

    await service.processQueue();

    final capturedInspection = verify(
      () => inspectionRemoteDataSource.uploadInspection(captureAny()),
    ).captured.single as Inspection;

    expect(capturedInspection.clientId, clientId);
  });

  test('keeps inspection pending and schedules backoff on network failure', () async {
    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [queueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer((_) async => pendingInspection);
    when(() => inspectionRemoteDataSource.uploadInspection(pendingInspection))
        .thenThrow(const NetworkFailure());
    when(() => inspectionLocalDataSource.upsert(any()))
        .thenAnswer((_) async {});
    when(
      () => syncQueueDataSource.recordNetworkFailure(
        id: queueId,
        errorMessage: any(named: 'errorMessage'),
        retryCount: 1,
        nextRetryAt: any(named: 'nextRetryAt'),
      ),
    ).thenAnswer((_) async {});

    final result = await service.processQueue();

    expect(result.keptPending, 1);
    expect(result.markedFailed, 0);

    final captured = verify(
      () => inspectionLocalDataSource.upsert(captureAny()),
    ).captured.single as Inspection;

    expect(captured.status, InspectionSyncStatus.pending);
    verify(
      () => syncQueueDataSource.recordNetworkFailure(
        id: queueId,
        errorMessage: any(named: 'errorMessage'),
        retryCount: 1,
        nextRetryAt: any(named: 'nextRetryAt'),
      ),
    ).called(1);
    verifyNever(() => syncQueueDataSource.removeById(any()));
    verifyNever(() => syncQueueDataSource.markFailed(
          id: any(named: 'id'),
          errorMessage: any(named: 'errorMessage'),
        ));
  });

  test('marks inspection failed on validation error without auto retry', () async {
    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [queueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer((_) async => pendingInspection);
    when(() => inspectionRemoteDataSource.uploadInspection(pendingInspection))
        .thenThrow(
      const ValidationFailure(message: 'Payload inválido'),
    );
    when(() => inspectionLocalDataSource.upsert(any()))
        .thenAnswer((_) async {});
    when(() => syncQueueDataSource.removeById(queueId))
        .thenAnswer((_) async {});

    final result = await service.processQueue();

    expect(result.markedFailed, 1);

    final captured = verify(
      () => inspectionLocalDataSource.upsert(captureAny()),
    ).captured.single as Inspection;

    expect(captured.status, InspectionSyncStatus.failed);
    expect(captured.syncErrorMessage, 'Payload inválido');
    verify(() => syncQueueDataSource.removeById(queueId)).called(1);
    verifyNever(() => syncQueueDataSource.markFailed(
          id: any(named: 'id'),
          errorMessage: any(named: 'errorMessage'),
        ));
    verifyNever(() => syncQueueDataSource.recordNetworkFailure(
          id: any(named: 'id'),
          errorMessage: any(named: 'errorMessage'),
          retryCount: any(named: 'retryCount'),
          nextRetryAt: any(named: 'nextRetryAt'),
        ));
  });

  test('marks inspection failed on conflict error without auto retry', () async {
    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [queueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer((_) async => pendingInspection);
    when(() => inspectionRemoteDataSource.uploadInspection(pendingInspection))
        .thenThrow(const ConflictFailure('workOrderId inexistente'));
    when(() => inspectionLocalDataSource.upsert(any()))
        .thenAnswer((_) async {});
    when(() => syncQueueDataSource.removeById(queueId))
        .thenAnswer((_) async {});

    final result = await service.processQueue();

    expect(result.markedFailed, 1);
    verify(() => syncQueueDataSource.removeById(queueId)).called(1);
    verifyNever(() => syncQueueDataSource.recordNetworkFailure(
          id: any(named: 'id'),
          errorMessage: any(named: 'errorMessage'),
          retryCount: any(named: 'retryCount'),
          nextRetryAt: any(named: 'nextRetryAt'),
        ));
  });

  test('marks inspection failed when retry limit is exceeded', () async {
    final exhaustedQueueItem = queueItem.copyWith(retryCount: 4);

    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [exhaustedQueueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer((_) async => pendingInspection);
    when(() => inspectionRemoteDataSource.uploadInspection(pendingInspection))
        .thenThrow(const NetworkFailure());
    when(() => inspectionLocalDataSource.upsert(any()))
        .thenAnswer((_) async {});
    when(() => syncQueueDataSource.removeById(queueId))
        .thenAnswer((_) async {});

    final result = await service.processQueue();

    expect(result.markedFailed, 1);
    expect(result.keptPending, 0);

    final captured = verify(
      () => inspectionLocalDataSource.upsert(captureAny()),
    ).captured.single as Inspection;

    expect(captured.status, InspectionSyncStatus.failed);
    expect(
      captured.syncErrorMessage,
      contains('Limite de tentativas de sincronização excedido'),
    );
    verify(() => syncQueueDataSource.removeById(queueId)).called(1);
    verifyNever(() => syncQueueDataSource.recordNetworkFailure(
          id: any(named: 'id'),
          errorMessage: any(named: 'errorMessage'),
          retryCount: any(named: 'retryCount'),
          nextRetryAt: any(named: 'nextRetryAt'),
        ));
  });

  test('schedules exponential backoff using retry count', () async {
    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [queueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer((_) async => pendingInspection);
    when(() => inspectionRemoteDataSource.uploadInspection(pendingInspection))
        .thenThrow(const NetworkFailure());
    when(() => inspectionLocalDataSource.upsert(any()))
        .thenAnswer((_) async {});
    when(
      () => syncQueueDataSource.recordNetworkFailure(
        id: queueId,
        errorMessage: any(named: 'errorMessage'),
        retryCount: 1,
        nextRetryAt: any(named: 'nextRetryAt'),
      ),
    ).thenAnswer((_) async {});

    await service.processQueue();

    final capturedNextRetryAt = verify(
      () => syncQueueDataSource.recordNetworkFailure(
        id: queueId,
        errorMessage: any(named: 'errorMessage'),
        retryCount: 1,
        nextRetryAt: captureAny(named: 'nextRetryAt'),
      ),
    ).captured.single as DateTime;

    final expectedDelay = SyncBackoffPolicy.delayForAttempt(1);
    final actualDelay = capturedNextRetryAt.difference(DateTime.now());

    expect(actualDelay.inSeconds, greaterThanOrEqualTo(expectedDelay.inSeconds - 1));
    expect(actualDelay.inSeconds, lessThanOrEqualTo(expectedDelay.inSeconds + 1));
  });

  test('skips draft inspections and removes queue item', () async {
    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [queueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer(
      (_) async => pendingInspection.copyWith(
        status: InspectionSyncStatus.draft,
      ),
    );
    when(() => syncQueueDataSource.removeById(queueId))
        .thenAnswer((_) async {});

    final result = await service.processQueue();

    expect(result.skipped, 1);
    expect(result.processed, 0);
    verifyNever(() => inspectionRemoteDataSource.uploadInspection(any()));
    verify(() => syncQueueDataSource.removeById(queueId)).called(1);
  });

  test('processes queue items in order', () async {
    const secondClientId = 'client-456';
    final secondQueueItem = SyncQueueItem(
      id: 2,
      inspectionClientId: secondClientId,
      status: 'pending',
      retryCount: 0,
    );
    final secondInspection = pendingInspection.copyWith(
      clientId: secondClientId,
    );

    when(() => syncQueueDataSource.getProcessableItems()).thenAnswer(
      (_) async => [queueItem, secondQueueItem],
    );
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer((_) async => pendingInspection);
    when(() => inspectionLocalDataSource.getByClientId(secondClientId))
        .thenAnswer((_) async => secondInspection);
    when(() => inspectionRemoteDataSource.uploadInspection(any())).thenAnswer(
      (_) async => uploadedDto.copyWith(clientId: secondClientId),
    );
    when(() => inspectionLocalDataSource.upsert(any()))
        .thenAnswer((_) async {});
    when(() => syncQueueDataSource.removeById(any()))
        .thenAnswer((_) async {});

    final result = await service.processQueue();

    expect(result.processed, 2);
    expect(result.synced, 2);

    verifyInOrder([
      () => inspectionRemoteDataSource.uploadInspection(pendingInspection),
      () => inspectionRemoteDataSource.uploadInspection(secondInspection),
    ]);
  });

  test('syncs failed inspection after manual retry', () async {
    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [queueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer(
      (_) async => pendingInspection.copyWith(
        status: InspectionSyncStatus.failed,
        syncErrorMessage: 'Falha anterior',
      ),
    );
    when(() => inspectionRemoteDataSource.uploadInspection(any()))
        .thenAnswer((_) async => uploadedDto);
    when(() => inspectionLocalDataSource.upsert(any()))
        .thenAnswer((_) async {});
    when(() => syncQueueDataSource.removeById(queueId))
        .thenAnswer((_) async {});

    final result = await service.processQueue();

    expect(result.synced, 1);
    verify(() => inspectionRemoteDataSource.uploadInspection(any())).called(1);
  });

  test('removes queue item when inspection no longer exists', () async {
    when(() => syncQueueDataSource.getProcessableItems())
        .thenAnswer((_) async => [queueItem]);
    when(() => inspectionLocalDataSource.getByClientId(clientId))
        .thenAnswer((_) async => null);
    when(() => syncQueueDataSource.removeById(queueId))
        .thenAnswer((_) async {});

    final result = await service.processQueue();

    expect(result.skipped, 1);
    verify(() => syncQueueDataSource.removeById(queueId)).called(1);
    verifyNever(() => inspectionRemoteDataSource.uploadInspection(any()));
  });
}
