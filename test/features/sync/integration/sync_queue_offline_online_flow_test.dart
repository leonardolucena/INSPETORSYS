import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/utils/app_uuid_generator.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source_impl.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_remote_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source_impl.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_dto.dart';
import 'package:inspetorsys/features/inspections/data/repositories/inspection_repository_impl.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/entities/save_inspection_input.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/sync/domain/services/inspection_sync_service.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockInspectionRemoteDataSource extends Mock
    implements InspectionRemoteDataSource {}

void main() {
  late File databaseFile;
  late File fixturePhoto;
  late AppDatabase database;
  late InspectionLocalDataSourceImpl inspectionLocalDataSource;
  late SyncQueueLocalDataSourceImpl syncQueueLocalDataSource;
  late InspectionRepositoryImpl repository;
  late MockInspectionRemoteDataSource remoteDataSource;
  late InspectionSyncService syncService;

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

  const uploadedDto = InspectionDto(
    id: 'insp_1',
    clientId: 'client-offline-flow',
    workOrderId: 'wo_1001',
    notes: 'Observação válida para conclusão',
    condition: 'bom',
    photoUrl: '/uploads/photo.jpg',
    latitude: -7.1195,
    longitude: -34.845,
    capturedAt: null,
    syncedAt: null,
  );

  Future<AppDatabase> openDatabase() async {
    return AppDatabase.forTesting(NativeDatabase(databaseFile));
  }

  setUpAll(() {
    registerFallbackValue(
      Inspection(
        clientId: 'client-offline-flow',
        workOrderId: 'wo_1001',
        status: InspectionSyncStatus.pending,
        createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
        updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
      ),
    );
  });

  setUp(() async {
    databaseFile = File(
      '${Directory.systemTemp.path}/inspetorsys_sync_flow_${DateTime.now().microsecondsSinceEpoch}.db',
    );
    fixturePhoto = File('test/fixtures/photo.jpg');

    database = await openDatabase();
    inspectionLocalDataSource = InspectionLocalDataSourceImpl(database);
    syncQueueLocalDataSource = SyncQueueLocalDataSourceImpl(database);
    remoteDataSource = MockInspectionRemoteDataSource();
    repository = InspectionRepositoryImpl(
      inspectionLocalDataSource,
      syncQueueLocalDataSource,
      WorkOrderLocalDataSourceImpl(database),
      const AppUuidGenerator(),
    );
    syncService = InspectionSyncService(
      syncQueueLocalDataSource,
      inspectionLocalDataSource,
      remoteDataSource,
    );
  });

  tearDown(() async {
    await database.close();
    if (await databaseFile.exists()) {
      await databaseFile.delete();
    }
  });

  Future<String> completeInspectionOffline() async {
    final result = await repository.completeInspection(
      SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Observação válida para conclusão',
        photoPath: fixturePhoto.path,
        latitude: -7.1195,
        longitude: -34.845,
        condition: InspectionCondition.bom,
        formSchema: testFormSchema,
      ),
    );

    expect(result.isSuccess(), isTrue);
    return result.getOrNull()!.clientId;
  }

  test('queues inspection offline and syncs when connectivity is restored', () async {
    final clientId = await completeInspectionOffline();

    final pendingInspection =
        await inspectionLocalDataSource.getByClientId(clientId);
    final queuedItems = await syncQueueLocalDataSource.getProcessableItems();

    expect(pendingInspection?.status, InspectionSyncStatus.pending);
    expect(queuedItems, hasLength(1));
    expect(queuedItems.single.inspectionClientId, clientId);

    when(() => remoteDataSource.uploadInspection(any())).thenAnswer(
      (_) async => uploadedDto.copyWith(
        clientId: clientId,
        syncedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
      ),
    );

    final syncResult = await syncService.processQueue();

    expect(syncResult.processed, 1);
    expect(syncResult.synced, 1);

    final syncedInspection =
        await inspectionLocalDataSource.getByClientId(clientId);
    final remainingQueue =
        await syncQueueLocalDataSource.getProcessableItems();

    expect(syncedInspection?.status, InspectionSyncStatus.synced);
    expect(syncedInspection?.serverId, 'insp_1');
    expect(syncedInspection?.syncedAt, isNotNull);
    expect(remainingQueue, isEmpty);

    verify(() => remoteDataSource.uploadInspection(any())).called(1);
  });

  test('keeps inspection pending when sync runs without connectivity', () async {
    final clientId = await completeInspectionOffline();

    when(() => remoteDataSource.uploadInspection(any()))
        .thenThrow(const NetworkFailure());

    final syncResult = await syncService.processQueue();

    expect(syncResult.processed, 1);
    expect(syncResult.keptPending, 1);
    expect(syncResult.synced, 0);

    final pendingInspection =
        await inspectionLocalDataSource.getByClientId(clientId);
    final processableItems =
        await syncQueueLocalDataSource.getProcessableItems();

    expect(pendingInspection?.status, InspectionSyncStatus.pending);
    expect(pendingInspection?.syncErrorMessage, isNotNull);
    expect(processableItems, isEmpty);
  });

  test('syncs queued inspection after offline failure when back online', () async {
    final clientId = await completeInspectionOffline();

    when(() => remoteDataSource.uploadInspection(any()))
        .thenThrow(const NetworkFailure());

    await syncService.processQueue();

    await syncQueueLocalDataSource.enqueueInspection(clientId);

    when(() => remoteDataSource.uploadInspection(any())).thenAnswer(
      (_) async => uploadedDto.copyWith(
        clientId: clientId,
        syncedAt: DateTime.parse('2026-07-26T14:00:00.000Z'),
      ),
    );

    final syncResult = await syncService.processQueue();

    expect(syncResult.synced, 1);

    final syncedInspection =
        await inspectionLocalDataSource.getByClientId(clientId);
    final remainingQueue =
        await syncQueueLocalDataSource.getProcessableItems();

    expect(syncedInspection?.status, InspectionSyncStatus.synced);
    expect(remainingQueue, isEmpty);
  });
}
