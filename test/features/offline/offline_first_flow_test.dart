import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/core/utils/app_uuid_generator.dart';
import 'package:inspetorsys/features/inspections/data/datasources/drift_inspection_form_schema_cache_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source_impl.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source_impl.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_form_schema_dto.dart';
import 'package:inspetorsys/features/inspections/data/repositories/inspection_repository_impl.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/inspections/domain/entities/save_inspection_input.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_condition.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_form_field_type.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source_impl.dart';
import 'package:inspetorsys/features/work_orders/data/repositories/work_order_repository_impl.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:mocktail/mocktail.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_remote_data_source.dart';

class MockWorkOrderRemoteDataSource extends Mock
    implements WorkOrderRemoteDataSource {}

class MockNetworkMonitor extends Mock implements NetworkMonitor {}

void main() {
  late File databaseFile;
  late AppDatabase database;
  late MockWorkOrderRemoteDataSource remoteDataSource;
  late MockNetworkMonitor networkMonitor;
  late WorkOrderRepositoryImpl workOrderRepository;
  late InspectionRepositoryImpl inspectionRepository;
  late DriftInspectionFormSchemaCacheDataSource schemaCacheDataSource;

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
        label: 'Condição do ativo',
        required: true,
        options: ['bom', 'regular', 'ruim', 'crítico'],
      ),
      InspectionFormFieldSchema(
        key: 'photo',
        type: InspectionFormFieldType.photo,
        label: 'Foto da evidência',
        required: true,
      ),
      InspectionFormFieldSchema(
        key: 'location',
        type: InspectionFormFieldType.location,
        label: 'Local da inspeção',
        required: true,
      ),
    ],
  );

  final cachedWorkOrder = WorkOrder(
    id: 'wo_1001',
    code: 'OS-2026-001',
    title: 'Inspeção de poste',
    address: 'Rua das Acácias, 120',
    priority: WorkOrderPriority.high,
    status: WorkOrderStatus.open,
    latitude: -7.1195,
    longitude: -34.845,
    createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
    updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
    cachedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
  );

  setUp(() async {
    databaseFile = File(
      '${Directory.systemTemp.path}/inspetorsys_offline_flow_${DateTime.now().microsecondsSinceEpoch}.db',
    );
    database = AppDatabase.forTesting(NativeDatabase(databaseFile));

    remoteDataSource = MockWorkOrderRemoteDataSource();
    networkMonitor = MockNetworkMonitor();
    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => false);

    final workOrderLocalDataSource = WorkOrderLocalDataSourceImpl(database);
    schemaCacheDataSource = DriftInspectionFormSchemaCacheDataSource(database);

    workOrderRepository = WorkOrderRepositoryImpl(
      remoteDataSource,
      workOrderLocalDataSource,
      schemaCacheDataSource,
      networkMonitor,
    );

    inspectionRepository = InspectionRepositoryImpl(
      InspectionLocalDataSourceImpl(database),
      SyncQueueLocalDataSourceImpl(database),
      workOrderLocalDataSource,
      const AppUuidGenerator(),
    );

    await workOrderLocalDataSource.upsert(cachedWorkOrder);
    await schemaCacheDataSource.save(
      const InspectionFormSchemaDto(
        workOrderId: 'wo_1001',
        fields: [
          InspectionFormFieldSchemaDto(
            key: 'observation',
            type: 'text',
            label: 'Observação',
            isRequired: true,
            minLength: 10,
          ),
        ],
      ),
    );
  });

  tearDown(() async {
    await database.close();
    if (databaseFile.existsSync()) {
      databaseFile.deleteSync();
    }
  });

  test('offline work order list reads from drift without remote calls', () async {
    final result = await workOrderRepository.getWorkOrders();

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull(), hasLength(1));
    verifyNever(() => remoteDataSource.fetchWorkOrders());
  });

  test('offline work order detail reads cached coordinates', () async {
    final result = await workOrderRepository.getWorkOrderById('wo_1001');

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull()?.latitude, cachedWorkOrder.latitude);
    verifyNever(() => remoteDataSource.fetchWorkOrderById(any()));
  });

  test('offline form schema resolves from drift cache', () async {
    final result = await workOrderRepository.getInspectionFormSchema('wo_1001');

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull()?.fields, hasLength(1));
    verifyNever(() => remoteDataSource.fetchInspectionFormSchema(any()));
  });

  test('draft persists denormalized work order context for offline resume', () async {
    final draftResult = await inspectionRepository.saveDraft(
      SaveInspectionInput(
        workOrderId: 'wo_1001',
        notes: 'Rascunho offline',
        condition: InspectionCondition.bom,
        formSchema: testFormSchema,
      ),
    );

    expect(draftResult.isSuccess(), isTrue);

    final inspection = draftResult.getOrThrow();
    expect(inspection.workOrderCode, 'OS-2026-001');
    expect(inspection.workOrderLatitude, cachedWorkOrder.latitude);
    expect(inspection.workOrderLongitude, cachedWorkOrder.longitude);
    expect(inspection.formSchema, isNotNull);
    expect(inspection.status, InspectionSyncStatus.draft);
  });
}
