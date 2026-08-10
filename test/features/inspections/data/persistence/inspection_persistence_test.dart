import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/core/utils/app_uuid_generator.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source_impl.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source_impl.dart';
import 'package:inspetorsys/features/inspections/data/repositories/inspection_repository_impl.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source_impl.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/entities/save_inspection_input.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

void main() {
  late File databaseFile;
  late AppDatabase database;
  late InspectionLocalDataSourceImpl inspectionLocalDataSource;
  late SyncQueueLocalDataSourceImpl syncQueueLocalDataSource;
  late InspectionRepositoryImpl repository;

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

  Future<AppDatabase> openDatabase() async {
    return AppDatabase.forTesting(NativeDatabase(databaseFile));
  }

  setUp(() async {
    databaseFile = File(
      '${Directory.systemTemp.path}/inspetorsys_persistence_${DateTime.now().microsecondsSinceEpoch}.db',
    );
    database = await openDatabase();
    inspectionLocalDataSource = InspectionLocalDataSourceImpl(database);
    syncQueueLocalDataSource = SyncQueueLocalDataSourceImpl(database);
    repository = InspectionRepositoryImpl(
      inspectionLocalDataSource,
      syncQueueLocalDataSource,
      WorkOrderLocalDataSourceImpl(database),
      const AppUuidGenerator(),
    );
  });

  tearDown(() async {
    await database.close();
    if (await databaseFile.exists()) {
      await databaseFile.delete();
    }
  });

  test('draft inspection survives database reopen', () async {
    final saveResult = await repository.saveDraft(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Rascunho salvo offline',
      ),
    );

    expect(saveResult.isSuccess(), isTrue);
    final clientId = saveResult.getOrNull()!.clientId;

    await database.close();

    final reopenedDatabase = await openDatabase();
    final reopenedDataSource = InspectionLocalDataSourceImpl(reopenedDatabase);
    final persisted = await reopenedDataSource.getByClientId(clientId);

    expect(persisted, isNotNull);
    expect(persisted!.status, InspectionSyncStatus.draft);
    expect(persisted.notes, 'Rascunho salvo offline');

    await reopenedDatabase.close();
  });

  test('completed inspection and sync queue survive database reopen', () async {
    final completeResult = await repository.completeInspection(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Observação válida para conclusão',
        photoPath: '/tmp/photo.jpg',
        latitude: -7.1195,
        longitude: -34.845,
        condition: InspectionCondition.bom,
        formSchema: testFormSchema,
      ),
    );

    expect(completeResult.isSuccess(), isTrue);
    final clientId = completeResult.getOrNull()!.clientId;

    await database.close();

    final reopenedDatabase = await openDatabase();
    final reopenedInspectionDataSource =
        InspectionLocalDataSourceImpl(reopenedDatabase);
    final reopenedQueueDataSource =
        SyncQueueLocalDataSourceImpl(reopenedDatabase);

    final persistedInspection =
        await reopenedInspectionDataSource.getByClientId(clientId);
    final queueItems = await reopenedQueueDataSource.getProcessableItems();

    expect(persistedInspection?.status, InspectionSyncStatus.pending);
    expect(queueItems, hasLength(1));
    expect(queueItems.single.inspectionClientId, clientId);

    await reopenedDatabase.close();
  });

  test('getLocalInspections filters by status', () async {
    await repository.saveDraft(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Rascunho local',
      ),
    );

    await repository.completeInspection(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Observação válida para conclusão',
        photoPath: '/tmp/photo.jpg',
        latitude: -7.1195,
        longitude: -34.845,
        condition: InspectionCondition.bom,
        formSchema: testFormSchema,
      ),
    );

    final drafts = await repository.getLocalInspections(
      status: InspectionSyncStatus.draft,
    );
    final pending = await repository.getLocalInspections(
      status: InspectionSyncStatus.pending,
    );

    expect(drafts.getOrNull(), hasLength(1));
    expect(pending.getOrNull(), hasLength(1));
  });

  test('saveDraft removes inspection from sync queue', () async {
    final completeResult = await repository.completeInspection(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Observação válida para conclusão',
        photoPath: '/tmp/photo.jpg',
        latitude: -7.1195,
        longitude: -34.845,
        condition: InspectionCondition.bom,
        formSchema: testFormSchema,
      ),
    );

    final clientId = completeResult.getOrNull()!.clientId;

    var queueItems = await syncQueueLocalDataSource.getProcessableItems();
    expect(queueItems, hasLength(1));

    await repository.saveDraft(
      SaveInspectionInput(
        workOrderId: 'wo_1001',
        clientId: clientId,
        notes: 'Voltou para rascunho',
      ),
    );

    queueItems = await syncQueueLocalDataSource.getProcessableItems();
    expect(queueItems, isEmpty);

    final inspection = await inspectionLocalDataSource.getByClientId(clientId);
    expect(inspection?.status, InspectionSyncStatus.draft);
  });

  test('retryFailedInspection requeues failed inspection', () async {
    final completeResult = await repository.completeInspection(
      const SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Observação válida para conclusão',
        photoPath: '/tmp/photo.jpg',
        latitude: -7.1195,
        longitude: -34.845,
        condition: InspectionCondition.bom,
        formSchema: testFormSchema,
      ),
    );

    final clientId = completeResult.getOrNull()!.clientId;

    await inspectionLocalDataSource.upsert(
      Inspection(
        clientId: clientId,
        workOrderId: 'wo_1001',
        status: InspectionSyncStatus.failed,
        syncErrorMessage: 'Falha de validação',
        createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
        updatedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
      ),
    );

    final retryResult = await repository.retryFailedInspection(clientId);

    expect(retryResult.isSuccess(), isTrue);

    final inspection = await inspectionLocalDataSource.getByClientId(clientId);
    final queueItems = await syncQueueLocalDataSource.getProcessableItems();

    expect(inspection?.status, InspectionSyncStatus.pending);
    expect(inspection?.syncErrorMessage, isNull);
    expect(queueItems, hasLength(1));
    expect(queueItems.single.inspectionClientId, clientId);
  });
}
