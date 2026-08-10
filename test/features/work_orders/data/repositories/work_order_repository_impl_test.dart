import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_form_schema_cache_data_source.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_form_schema_dto.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_remote_data_source.dart';
import 'package:inspetorsys/features/work_orders/data/dto/work_order_dto.dart';
import 'package:inspetorsys/features/work_orders/data/repositories/work_order_repository_impl.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:mocktail/mocktail.dart';

class MockWorkOrderRemoteDataSource extends Mock
    implements WorkOrderRemoteDataSource {}

class MockWorkOrderLocalDataSource extends Mock
    implements WorkOrderLocalDataSource {}

class MockInspectionFormSchemaCacheDataSource extends Mock
    implements InspectionFormSchemaCacheDataSource {}

class MockNetworkMonitor extends Mock implements NetworkMonitor {}

void main() {
  late MockWorkOrderRemoteDataSource remoteDataSource;
  late MockWorkOrderLocalDataSource localDataSource;
  late MockInspectionFormSchemaCacheDataSource formSchemaCacheDataSource;
  late MockNetworkMonitor networkMonitor;
  late WorkOrderRepositoryImpl repository;

  final sampleDto = WorkOrderDto(
    id: 'wo_1001',
    code: 'OS-2026-001',
    title: 'Inspeção de poste',
    address: 'Rua das Acácias, 120',
    priority: WorkOrderPriority.high,
    status: WorkOrderStatus.open,
    createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
    updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
  );

  final sampleWorkOrder = WorkOrder(
    id: 'wo_1001',
    code: 'OS-2026-001',
    title: 'Inspeção de poste',
    address: 'Rua das Acácias, 120',
    priority: WorkOrderPriority.high,
    status: WorkOrderStatus.open,
    createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
    updatedAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
  );

  setUpAll(() {
    registerFallbackValue(sampleWorkOrder);
    registerFallbackValue(
      const InspectionFormSchemaDto(
        workOrderId: 'wo_1001',
        fields: [],
      ),
    );
  });

  setUp(() {
    remoteDataSource = MockWorkOrderRemoteDataSource();
    localDataSource = MockWorkOrderLocalDataSource();
    formSchemaCacheDataSource = MockInspectionFormSchemaCacheDataSource();
    networkMonitor = MockNetworkMonitor();
    repository = WorkOrderRepositoryImpl(
      remoteDataSource,
      localDataSource,
      formSchemaCacheDataSource,
      networkMonitor,
    );

    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => true);
    when(() => formSchemaCacheDataSource.get(any()))
        .thenAnswer((_) async => null);
    when(() => formSchemaCacheDataSource.save(any()))
        .thenAnswer((_) async {});

    when(() => remoteDataSource.fetchWorkOrders(status: any(named: 'status')))
        .thenAnswer((_) async => [sampleDto]);
    when(() => localDataSource.replaceAll(any())).thenAnswer((_) async {});
    when(() => localDataSource.upsert(any())).thenAnswer((_) async {});
    when(() => localDataSource.getWorkOrders(status: any(named: 'status')))
        .thenAnswer((_) async => [sampleDto.toDomain()]);
  });

  test('fetches remote and returns cached filtered list when online', () async {
    final result = await repository.getWorkOrders(
      status: WorkOrderStatus.open,
    );

    expect(result.isSuccess(), isTrue);
    verify(
      () => remoteDataSource.fetchWorkOrders(status: WorkOrderStatus.open),
    ).called(1);
    verify(() => localDataSource.upsert(any())).called(1);
    verifyNever(() => localDataSource.replaceAll(any()));
    verify(
      () => localDataSource.getWorkOrders(status: WorkOrderStatus.open),
    ).called(1);
  });

  test('returns cached data when remote fails', () async {
    when(() => remoteDataSource.fetchWorkOrders(status: any(named: 'status')))
        .thenThrow(const NetworkFailure('offline'));

    final result = await repository.getWorkOrders();

    expect(result.isSuccess(), isTrue);
    verify(() => localDataSource.getWorkOrders(status: null)).called(1);
  });

  test('returns cached data when offline without calling remote', () async {
    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => false);

    final result = await repository.getWorkOrders();

    expect(result.isSuccess(), isTrue);
    verifyNever(() => remoteDataSource.fetchWorkOrders());
    verify(() => localDataSource.getWorkOrders(status: null)).called(1);
  });

  test('returns failure when offline with empty cache', () async {
    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => false);
    when(() => localDataSource.getWorkOrders(status: any(named: 'status')))
        .thenAnswer((_) async => []);

    final result = await repository.getWorkOrders();

    expect(result.isError(), isTrue);
    expect(result.exceptionOrNull(), isA<NetworkFailure>());
    verifyNever(() => remoteDataSource.fetchWorkOrders());
  });

  test('getWorkOrderById returns remote item when online', () async {
    when(() => remoteDataSource.fetchWorkOrderById('wo_1001'))
        .thenAnswer((_) async => sampleDto);
    when(() => localDataSource.upsert(any())).thenAnswer((_) async {});

    final result = await repository.getWorkOrderById('wo_1001');

    expect(result.isSuccess(), isTrue);
    verify(() => localDataSource.upsert(any())).called(1);
  });

  test('getWorkOrderById returns cached item when remote fails', () async {
    when(() => remoteDataSource.fetchWorkOrderById('wo_1001'))
        .thenThrow(const NetworkFailure());
    when(() => localDataSource.getWorkOrderById('wo_1001'))
        .thenAnswer((_) async => sampleWorkOrder);

    final result = await repository.getWorkOrderById('wo_1001');

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull()?.id, 'wo_1001');
    verifyNever(() => localDataSource.upsert(any()));
  });

  test('getWorkOrderById returns cached item when offline', () async {
    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => false);
    when(() => localDataSource.getWorkOrderById('wo_1001'))
        .thenAnswer((_) async => sampleWorkOrder);

    final result = await repository.getWorkOrderById('wo_1001');

    expect(result.isSuccess(), isTrue);
    verifyNever(() => remoteDataSource.fetchWorkOrderById(any()));
  });

  test('getWorkOrderById fails when remote and cache are unavailable', () async {
    when(() => remoteDataSource.fetchWorkOrderById('wo_1001'))
        .thenThrow(const NetworkFailure());
    when(() => localDataSource.getWorkOrderById('wo_1001'))
        .thenAnswer((_) async => null);

    final result = await repository.getWorkOrderById('wo_1001');

    expect(result.isError(), isTrue);
    expect(result.exceptionOrNull(), isA<NetworkFailure>());
  });

  test('getWorkOrders with forceRefresh returns cache when remote fails', () async {
    when(() => remoteDataSource.fetchWorkOrders(status: any(named: 'status')))
        .thenThrow(const NetworkFailure());

    final result = await repository.getWorkOrders(forceRefresh: true);

    expect(result.isSuccess(), isTrue);
    verify(() => localDataSource.getWorkOrders(status: null)).called(1);
  });

  test('getInspectionFormSchema returns schema when remote succeeds', () async {
    const schemaDto = InspectionFormSchemaDto(
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
    );

    when(() => remoteDataSource.fetchInspectionFormSchema('wo_1001'))
        .thenAnswer((_) async => schemaDto);
    when(() => formSchemaCacheDataSource.save(schemaDto))
        .thenAnswer((_) async {});

    final result = await repository.getInspectionFormSchema('wo_1001');

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull()?.workOrderId, 'wo_1001');
    expect(result.getOrNull()?.fields, hasLength(1));
    verify(() => formSchemaCacheDataSource.save(schemaDto)).called(1);
  });

  test('getInspectionFormSchema returns cached schema when remote fails', () async {
    const schemaDto = InspectionFormSchemaDto(
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
    );

    when(() => remoteDataSource.fetchInspectionFormSchema('wo_1001'))
        .thenThrow(const NetworkFailure('offline'));
    when(() => formSchemaCacheDataSource.get('wo_1001'))
        .thenAnswer((_) async => schemaDto);

    final result = await repository.getInspectionFormSchema('wo_1001');

    expect(result.isSuccess(), isTrue);
    expect(result.getOrNull()?.workOrderId, 'wo_1001');
    expect(result.getOrNull()?.fields, hasLength(1));
    verifyNever(() => formSchemaCacheDataSource.save(any()));
  });

  test(
    'getInspectionFormSchema returns default schema when remote fails without cache',
    () async {
      when(() => remoteDataSource.fetchInspectionFormSchema('wo_1001'))
          .thenThrow(const NetworkFailure('offline'));
      when(() => formSchemaCacheDataSource.get('wo_1001'))
          .thenAnswer((_) async => null);

      final result = await repository.getInspectionFormSchema('wo_1001');

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.workOrderId, 'wo_1001');
      expect(result.getOrNull()?.fields, hasLength(4));
    },
  );

  test('getInspectionFormSchema uses cache when offline', () async {
    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => false);
    const schemaDto = InspectionFormSchemaDto(
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
    );
    when(() => formSchemaCacheDataSource.get('wo_1001'))
        .thenAnswer((_) async => schemaDto);

    final result = await repository.getInspectionFormSchema('wo_1001');

    expect(result.isSuccess(), isTrue);
    verifyNever(() => remoteDataSource.fetchInspectionFormSchema(any()));
  });
}
