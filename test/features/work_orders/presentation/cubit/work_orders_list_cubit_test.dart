import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_cached_work_orders_use_case.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_work_orders_use_case.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_orders_list_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_orders_list_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWorkOrdersUseCase extends Mock implements GetWorkOrdersUseCase {}

class MockGetCachedWorkOrdersUseCase extends Mock
    implements GetCachedWorkOrdersUseCase {}

class MockNetworkMonitor extends Mock implements NetworkMonitor {}

WorkOrdersListCubit createCubit({
  required MockGetWorkOrdersUseCase getWorkOrdersUseCase,
  required MockGetCachedWorkOrdersUseCase getCachedWorkOrdersUseCase,
  required MockNetworkMonitor networkMonitor,
}) {
  return WorkOrdersListCubit(
    getWorkOrdersUseCase,
    getCachedWorkOrdersUseCase,
    networkMonitor,
  );
}

void main() {
  late MockGetWorkOrdersUseCase getWorkOrdersUseCase;
  late MockGetCachedWorkOrdersUseCase getCachedWorkOrdersUseCase;
  late MockNetworkMonitor networkMonitor;
  late WorkOrdersListCubit cubit;

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

  setUp(() {
    getWorkOrdersUseCase = MockGetWorkOrdersUseCase();
    getCachedWorkOrdersUseCase = MockGetCachedWorkOrdersUseCase();
    networkMonitor = MockNetworkMonitor();

    when(
      () => getCachedWorkOrdersUseCase(status: any(named: 'status')),
    ).thenAnswer((_) async => const []);
    when(() => networkMonitor.hasInternetAccess())
        .thenAnswer((_) async => true);

    cubit = createCubit(
      getWorkOrdersUseCase: getWorkOrdersUseCase,
      getCachedWorkOrdersUseCase: getCachedWorkOrdersUseCase,
      networkMonitor: networkMonitor,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  blocTest<WorkOrdersListCubit, WorkOrdersListState>(
    'emits success when work orders are loaded',
    build: () {
      when(
        () => getWorkOrdersUseCase(
          status: any(named: 'status'),
          forceRefresh: any(named: 'forceRefresh'),
        ),
      ).thenAnswer((_) async => appSuccess([sampleWorkOrder]));

      return createCubit(
        getWorkOrdersUseCase: getWorkOrdersUseCase,
        getCachedWorkOrdersUseCase: getCachedWorkOrdersUseCase,
        networkMonitor: networkMonitor,
      );
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const WorkOrdersListState(status: WorkOrdersListStatus.loading),
      WorkOrdersListState(
        status: WorkOrdersListStatus.success,
        workOrders: [sampleWorkOrder],
      ),
    ],
  );

  blocTest<WorkOrdersListCubit, WorkOrdersListState>(
    'emits empty when no work orders are returned',
    build: () {
      when(
        () => getWorkOrdersUseCase(
          status: any(named: 'status'),
          forceRefresh: any(named: 'forceRefresh'),
        ),
      ).thenAnswer((_) async => appSuccess(const []));

      return createCubit(
        getWorkOrdersUseCase: getWorkOrdersUseCase,
        getCachedWorkOrdersUseCase: getCachedWorkOrdersUseCase,
        networkMonitor: networkMonitor,
      );
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const WorkOrdersListState(status: WorkOrdersListStatus.loading),
      const WorkOrdersListState(status: WorkOrdersListStatus.empty),
    ],
  );

  blocTest<WorkOrdersListCubit, WorkOrdersListState>(
    'emits failure when loading fails',
    build: () {
      when(
        () => getWorkOrdersUseCase(
          status: any(named: 'status'),
          forceRefresh: any(named: 'forceRefresh'),
        ),
      ).thenAnswer((_) async => appFailure(const NetworkFailure()));

      return createCubit(
        getWorkOrdersUseCase: getWorkOrdersUseCase,
        getCachedWorkOrdersUseCase: getCachedWorkOrdersUseCase,
        networkMonitor: networkMonitor,
      );
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const WorkOrdersListState(status: WorkOrdersListStatus.loading),
      const WorkOrdersListState(
        status: WorkOrdersListStatus.failure,
        errorMessage: 'Sem conexão com a internet. Tente novamente.',
      ),
    ],
  );

  blocTest<WorkOrdersListCubit, WorkOrdersListState>(
    'reloads with status filter',
    build: () {
      when(
        () => getWorkOrdersUseCase(
          status: any(named: 'status'),
          forceRefresh: any(named: 'forceRefresh'),
        ),
      ).thenAnswer((_) async => appSuccess([sampleWorkOrder]));

      return createCubit(
        getWorkOrdersUseCase: getWorkOrdersUseCase,
        getCachedWorkOrdersUseCase: getCachedWorkOrdersUseCase,
        networkMonitor: networkMonitor,
      );
    },
    act: (cubit) => cubit.setStatusFilter(WorkOrderStatus.open),
    expect: () => [
      const WorkOrdersListState(
        status: WorkOrdersListStatus.loading,
        statusFilter: WorkOrderStatus.open,
      ),
      WorkOrdersListState(
        status: WorkOrdersListStatus.success,
        statusFilter: WorkOrderStatus.open,
        workOrders: [sampleWorkOrder],
      ),
    ],
  );

  blocTest<WorkOrdersListCubit, WorkOrdersListState>(
    'refresh updates list while keeping success status',
    build: () {
      when(
        () => getWorkOrdersUseCase(
          status: any(named: 'status'),
          forceRefresh: true,
        ),
      ).thenAnswer((_) async => appSuccess([sampleWorkOrder]));

      return createCubit(
        getWorkOrdersUseCase: getWorkOrdersUseCase,
        getCachedWorkOrdersUseCase: getCachedWorkOrdersUseCase,
        networkMonitor: networkMonitor,
      );
    },
    seed: () => WorkOrdersListState(
      status: WorkOrdersListStatus.success,
      workOrders: const [],
    ),
    act: (cubit) => cubit.refresh(),
    expect: () => [
      WorkOrdersListState(
        status: WorkOrdersListStatus.success,
        workOrders: const [],
        isRefreshing: true,
      ),
      WorkOrdersListState(
        status: WorkOrdersListStatus.success,
        workOrders: [sampleWorkOrder],
      ),
    ],
  );

  blocTest<WorkOrdersListCubit, WorkOrdersListState>(
    'refresh keeps success status and sets error message on failure',
    build: () {
      when(
        () => getWorkOrdersUseCase(
          status: any(named: 'status'),
          forceRefresh: true,
        ),
      ).thenAnswer((_) async => appFailure(const NetworkFailure()));

      return createCubit(
        getWorkOrdersUseCase: getWorkOrdersUseCase,
        getCachedWorkOrdersUseCase: getCachedWorkOrdersUseCase,
        networkMonitor: networkMonitor,
      );
    },
    seed: () => WorkOrdersListState(
      status: WorkOrdersListStatus.success,
      workOrders: [sampleWorkOrder],
    ),
    act: (cubit) => cubit.refresh(),
    expect: () => [
      WorkOrdersListState(
        status: WorkOrdersListStatus.success,
        workOrders: [sampleWorkOrder],
        isRefreshing: true,
      ),
      WorkOrdersListState(
        status: WorkOrdersListStatus.success,
        workOrders: [sampleWorkOrder],
        errorMessage: 'Sem conexão com a internet. Tente novamente.',
      ),
    ],
  );
}
