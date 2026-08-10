import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/utils/uuid_generator.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_remote_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_dto.dart';
import 'package:inspetorsys/features/inspections/data/repositories/inspection_repository_impl.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/entities/save_inspection_input.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockInspectionLocalDataSource extends Mock
    implements InspectionLocalDataSource {}

class MockInspectionRemoteDataSource extends Mock
    implements InspectionRemoteDataSource {}

class MockSyncQueueLocalDataSource extends Mock
    implements SyncQueueLocalDataSource {}

class MockWorkOrderLocalDataSource extends Mock
    implements WorkOrderLocalDataSource {}

class MockNetworkMonitor extends Mock implements NetworkMonitor {}

class MockUuidGenerator extends Mock implements UuidGenerator {}

void main() {
  late MockInspectionLocalDataSource localDataSource;
  late MockInspectionRemoteDataSource remoteDataSource;
  late MockSyncQueueLocalDataSource syncQueueDataSource;
  late MockWorkOrderLocalDataSource workOrderLocalDataSource;
  late MockNetworkMonitor networkMonitor;
  late MockUuidGenerator uuidGenerator;
  late InspectionRepositoryImpl repository;

  const clientId = 'client-123';

  const testFormSchema = InspectionFormSchema(
    workOrderId: 'wo_1001',
    fields: [
      InspectionFormFieldSchema(
        key: 'observation',
        type: InspectionFormFieldType.text,
        label: 'Observação',
        required: true,
        minLength: 10,
      ),
      InspectionFormFieldSchema(
        key: 'condition',
        type: InspectionFormFieldType.select,
        label: 'Condição',
        required: true,
        options: ['bom'],
      ),
      InspectionFormFieldSchema(
        key: 'photo',
        type: InspectionFormFieldType.photo,
        label: 'Foto',
        required: true,
      ),
      InspectionFormFieldSchema(
        key: 'location',
        type: InspectionFormFieldType.location,
        label: 'GPS',
        required: true,
      ),
    ],
  );

  setUp(() {
    localDataSource = MockInspectionLocalDataSource();
    remoteDataSource = MockInspectionRemoteDataSource();
    syncQueueDataSource = MockSyncQueueLocalDataSource();
    workOrderLocalDataSource = MockWorkOrderLocalDataSource();
    networkMonitor = MockNetworkMonitor();
    uuidGenerator = MockUuidGenerator();
    repository = InspectionRepositoryImpl(
      localDataSource,
      remoteDataSource,
      syncQueueDataSource,
      workOrderLocalDataSource,
      networkMonitor,
      uuidGenerator,
    );

    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => true);
    when(() => remoteDataSource.fetchInspections()).thenAnswer((_) async => []);

    when(() => uuidGenerator.generateClientId()).thenReturn(clientId);
    when(() => localDataSource.getByClientId(any())).thenAnswer((_) async => null);
    when(() => localDataSource.upsert(any())).thenAnswer((_) async {});
    when(() => workOrderLocalDataSource.getWorkOrderById(any()))
        .thenAnswer((_) async => null);
    when(() => syncQueueDataSource.enqueueInspection(any()))
        .thenAnswer((_) async {});
    when(() => syncQueueDataSource.removeByInspectionClientId(any()))
        .thenAnswer((_) async {});
  });

  setUpAll(() {
    registerFallbackValue(
      Inspection(
        clientId: clientId,
        workOrderId: 'wo_1001',
        status: InspectionSyncStatus.draft,
        createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
        updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      ),
    );
  });

  test('saveDraft persists inspection with draft status', () async {
    final result = await repository.saveDraft(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Rascunho parcial',
      ),
    );

    expect(result.isSuccess(), isTrue);
    verify(() => syncQueueDataSource.removeByInspectionClientId(clientId))
        .called(1);
    verifyNever(() => syncQueueDataSource.enqueueInspection(any()));
  });

  test('saveDraft removes inspection from sync queue', () async {
    when(() => localDataSource.getByClientId(clientId)).thenAnswer(
      (_) async => Inspection(
        clientId: clientId,
        workOrderId: 'wo_1001',
        status: InspectionSyncStatus.pending,
        createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
        updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      ),
    );

    final result = await repository.saveDraft(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        clientId: clientId,
        notes: 'Rascunho parcial',
      ),
    );

    expect(result.isSuccess(), isTrue);
    verify(() => syncQueueDataSource.removeByInspectionClientId(clientId))
        .called(1);
    verifyNever(() => syncQueueDataSource.enqueueInspection(any()));
  });

  test('completeInspection enqueues sync when validation passes', () async {
    final result = await repository.completeInspection(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Observação válida para conclusão',
        photoPath: '/tmp/photo.jpg',
        latitude: -7.1195,
        longitude: -34.845,
        condition: InspectionCondition.ruim,
        formSchema: testFormSchema,
      ),
    );

    expect(result.isSuccess(), isTrue);
    verify(() => syncQueueDataSource.enqueueInspection(clientId)).called(1);
  });

  test('completeInspection fails when required fields are missing', () async {
    final result = await repository.completeInspection(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'curta',
        formSchema: testFormSchema,
      ),
    );

    expect(result.isError(), isTrue);
    verifyNever(() => syncQueueDataSource.enqueueInspection(any()));
  });

  test('retryFailedInspection requeues failed inspection as pending', () async {
    when(() => localDataSource.getByClientId(clientId)).thenAnswer(
      (_) async => Inspection(
        clientId: clientId,
        workOrderId: 'wo_1001',
        status: InspectionSyncStatus.failed,
        syncErrorMessage: 'Erro de rede',
        createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
        updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      ),
    );

    final result = await repository.retryFailedInspection(clientId);

    expect(result.isSuccess(), isTrue);
    verify(() => syncQueueDataSource.enqueueInspection(clientId)).called(1);
  });

  test('retryFailedInspection fails when inspection is not failed', () async {
    when(() => localDataSource.getByClientId(clientId)).thenAnswer(
      (_) async => Inspection(
        clientId: clientId,
        workOrderId: 'wo_1001',
        status: InspectionSyncStatus.pending,
        createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
        updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      ),
    );

    final result = await repository.retryFailedInspection(clientId);

    expect(result.isError(), isTrue);
    verifyNever(() => syncQueueDataSource.enqueueInspection(any()));
  });

  test('getPendingInspectionsCount returns pending inspections total', () async {
    when(
      () => localDataSource.countByStatus(InspectionSyncStatus.pending),
    ).thenAnswer((_) async => 2);

    final result = await repository.getPendingInspectionsCount();

    expect(result.getOrNull(), 2);
  });

  test('getInspections fetches remote and merges synced inspections', () async {
    const remoteClientId = 'remote-client-1';
    final remoteDto = InspectionDto(
      id: 'insp_remote',
      clientId: remoteClientId,
      workOrderId: 'wo_1001',
      notes: 'Inspeção de outro dispositivo',
      photoUrl: '/uploads/photo.jpg',
      latitude: -7.1195,
      longitude: -34.845,
      capturedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      syncedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
    );
    final syncedInspection = Inspection(
      clientId: remoteClientId,
      serverId: 'insp_remote',
      workOrderId: 'wo_1001',
      status: InspectionSyncStatus.synced,
      notes: 'Inspeção de outro dispositivo',
      photoPath: '/uploads/photo.jpg',
      createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      updatedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
      syncedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
    );

    when(() => remoteDataSource.fetchInspections())
        .thenAnswer((_) async => [remoteDto]);
    when(() => localDataSource.getByClientId(remoteClientId))
        .thenAnswer((_) async => null);
    when(() => localDataSource.list(status: any(named: 'status')))
        .thenAnswer((_) async => [syncedInspection]);

    final result = await repository.getInspections();

    expect(result.isSuccess(), isTrue);
    verify(() => remoteDataSource.fetchInspections()).called(1);
    verify(() => localDataSource.upsert(any())).called(1);
  });

  test('getInspections preserves local pending inspection over remote', () async {
    const clientId = 'client-pending';
    final pendingInspection = Inspection(
      clientId: clientId,
      workOrderId: 'wo_1001',
      status: InspectionSyncStatus.pending,
      notes: 'Aguardando envio',
      photoPath: '/tmp/photo.jpg',
      createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      updatedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
    );
    final remoteDto = InspectionDto(
      id: 'insp_1',
      clientId: clientId,
      workOrderId: 'wo_1001',
      notes: 'Versão do servidor',
      photoUrl: '/uploads/photo.jpg',
      capturedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      syncedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
    );

    when(() => remoteDataSource.fetchInspections())
        .thenAnswer((_) async => [remoteDto]);
    when(() => localDataSource.getByClientId(clientId))
        .thenAnswer((_) async => pendingInspection);
    when(() => localDataSource.list(status: any(named: 'status')))
        .thenAnswer((_) async => [pendingInspection]);

    final result = await repository.getInspections();

    expect(result.isSuccess(), isTrue);
    verifyNever(() => localDataSource.upsert(any()));
  });

  test('getInspections returns cached data when offline', () async {
    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => false);
    when(() => localDataSource.list(status: any(named: 'status')))
        .thenAnswer((_) async => []);

    final result = await repository.getInspections();

    expect(result.isError(), isTrue);
    verifyNever(() => remoteDataSource.fetchInspections());
  });

  test('getInspectionByClientId fetches remote and merges synced inspection',
      () async {
    final remoteDto = InspectionDto(
      id: 'insp_1',
      clientId: clientId,
      workOrderId: 'wo_1001',
      notes: 'Inspeção remota',
      photoUrl: '/uploads/photo.jpg',
      latitude: -7.1195,
      longitude: -34.845,
      capturedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      syncedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
    );

    when(() => remoteDataSource.fetchInspectionById(clientId))
        .thenAnswer((_) async => remoteDto);
    when(() => localDataSource.getByClientId(clientId)).thenAnswer(
      (_) async => Inspection(
        clientId: clientId,
        workOrderId: 'wo_1001',
        status: InspectionSyncStatus.synced,
        notes: 'Inspeção remota',
        createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
        updatedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
        syncedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
      ),
    );

    final result = await repository.getInspectionByClientId(clientId);

    expect(result.isSuccess(), isTrue);
    verify(() => remoteDataSource.fetchInspectionById(clientId)).called(1);
    verify(() => localDataSource.upsert(any())).called(1);
  });

  test('getInspectionByClientId preserves local pending inspection over remote',
      () async {
    final remoteDto = InspectionDto(
      id: 'insp_1',
      clientId: clientId,
      workOrderId: 'wo_1001',
      notes: 'Inspeção remota',
    );

    when(() => remoteDataSource.fetchInspectionById(clientId))
        .thenAnswer((_) async => remoteDto);
    when(() => localDataSource.getByClientId(clientId)).thenAnswer(
      (_) async => Inspection(
        clientId: clientId,
        workOrderId: 'wo_1001',
        status: InspectionSyncStatus.pending,
        notes: 'Pendente local',
        createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
        updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      ),
    );

    final result = await repository.getInspectionByClientId(clientId);

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull()?.status, InspectionSyncStatus.pending);
    verifyNever(() => localDataSource.upsert(any()));
  });

  test('getInspectionByClientId returns cached data when offline', () async {
    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => false);
    when(() => localDataSource.getByClientId(clientId)).thenAnswer(
      (_) async => Inspection(
        clientId: clientId,
        workOrderId: 'wo_1001',
        status: InspectionSyncStatus.synced,
        createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
        updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      ),
    );

    final result = await repository.getInspectionByClientId(clientId);

    expect(result.isSuccess(), isTrue);
    verifyNever(() => remoteDataSource.fetchInspectionById(any()));
  });

  test('getLocalInspections returns cache failure on local error', () async {
    when(() => localDataSource.list(status: any(named: 'status')))
        .thenThrow(Exception('db error'));

    final result = await repository.getLocalInspections();

    expect(result.isError(), isTrue);
    expect(result.exceptionOrNull(), isA<CacheFailure>());
  });

  test('retryFailedInspection fails when inspection does not exist', () async {
    when(() => localDataSource.getByClientId(clientId))
        .thenAnswer((_) async => null);

    final result = await repository.retryFailedInspection(clientId);

    expect(result.isError(), isTrue);
    verifyNever(() => syncQueueDataSource.enqueueInspection(any()));
  });
}
