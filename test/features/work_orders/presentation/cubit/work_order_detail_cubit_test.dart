import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_cached_work_orders_use_case.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_work_order_by_id_use_case.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_order_detail_cubit.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_order_detail_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWorkOrderByIdUseCase extends Mock
    implements GetWorkOrderByIdUseCase {}

class MockGetCachedWorkOrderByIdUseCase extends Mock
    implements GetCachedWorkOrderByIdUseCase {}

class MockNetworkMonitor extends Mock implements NetworkMonitor {}

void main() {
  late MockGetWorkOrderByIdUseCase getWorkOrderByIdUseCase;
  late MockGetCachedWorkOrderByIdUseCase getCachedWorkOrderByIdUseCase;
  late MockNetworkMonitor networkMonitor;
  late WorkOrderDetailCubit cubit;

  final sampleWorkOrder = WorkOrder(
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
  );

  setUp(() {
    getWorkOrderByIdUseCase = MockGetWorkOrderByIdUseCase();
    getCachedWorkOrderByIdUseCase = MockGetCachedWorkOrderByIdUseCase();
    networkMonitor = MockNetworkMonitor();

    when(() => getCachedWorkOrderByIdUseCase(any()))
        .thenAnswer((_) async => null);
    when(() => networkMonitor.hasInternetAccess())
        .thenAnswer((_) async => true);

    cubit = WorkOrderDetailCubit(
      getWorkOrderByIdUseCase,
      getCachedWorkOrderByIdUseCase,
      networkMonitor,
    );
  });

  tearDown(() => cubit.close());

  blocTest<WorkOrderDetailCubit, WorkOrderDetailState>(
    'emits success when work order is loaded',
    build: () {
      when(() => getWorkOrderByIdUseCase('wo_1001'))
          .thenAnswer((_) async => appSuccess(sampleWorkOrder));
      return cubit;
    },
    act: (cubit) => cubit.load('wo_1001'),
    expect: () => [
      const WorkOrderDetailState(status: WorkOrderDetailStatus.loading),
      WorkOrderDetailState(
        status: WorkOrderDetailStatus.success,
        workOrder: sampleWorkOrder,
      ),
    ],
  );

  blocTest<WorkOrderDetailCubit, WorkOrderDetailState>(
    'emits failure with network message when loading fails',
    build: () {
      when(() => getWorkOrderByIdUseCase('wo_1001')).thenAnswer(
        (_) async => appFailure(
          const NetworkFailure(
            'Sem conexão com a internet. Verifique sua rede e tente novamente.',
          ),
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.load('wo_1001'),
    expect: () => [
      const WorkOrderDetailState(status: WorkOrderDetailStatus.loading),
      const WorkOrderDetailState(
        status: WorkOrderDetailStatus.failure,
        errorMessage:
            'Sem conexão com a internet. Verifique sua rede e tente novamente.',
      ),
    ],
  );

  blocTest<WorkOrderDetailCubit, WorkOrderDetailState>(
    'emits failure when work order is not found',
    build: () {
      when(() => getWorkOrderByIdUseCase('wo_missing'))
          .thenAnswer((_) async => appFailure(const CacheFailure()));
      return cubit;
    },
    act: (cubit) => cubit.load('wo_missing'),
    expect: () => [
      const WorkOrderDetailState(status: WorkOrderDetailStatus.loading),
      const WorkOrderDetailState(
        status: WorkOrderDetailStatus.failure,
        errorMessage: 'Não foi possível acessar os dados locais.',
      ),
    ],
  );
}
