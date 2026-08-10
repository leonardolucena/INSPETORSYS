import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/utils/uuid_generator.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source.dart';
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

class MockSyncQueueLocalDataSource extends Mock
    implements SyncQueueLocalDataSource {}

class MockWorkOrderLocalDataSource extends Mock
    implements WorkOrderLocalDataSource {}

class MockUuidGenerator extends Mock implements UuidGenerator {}

void main() {
  late MockInspectionLocalDataSource localDataSource;
  late MockSyncQueueLocalDataSource syncQueueDataSource;
  late MockWorkOrderLocalDataSource workOrderLocalDataSource;
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
    syncQueueDataSource = MockSyncQueueLocalDataSource();
    workOrderLocalDataSource = MockWorkOrderLocalDataSource();
    uuidGenerator = MockUuidGenerator();
    repository = InspectionRepositoryImpl(
      localDataSource,
      syncQueueDataSource,
      workOrderLocalDataSource,
      uuidGenerator,
    );

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
