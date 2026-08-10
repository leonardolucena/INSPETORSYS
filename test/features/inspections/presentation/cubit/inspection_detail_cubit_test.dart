import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_cached_inspections_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_inspection_by_client_id_use_case.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_detail_cubit.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_detail_state.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_cached_work_orders_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockGetInspectionByClientIdUseCase extends Mock
    implements GetInspectionByClientIdUseCase {}

class MockGetCachedInspectionByClientIdUseCase extends Mock
    implements GetCachedInspectionByClientIdUseCase {}

class MockGetCachedWorkOrderByIdUseCase extends Mock
    implements GetCachedWorkOrderByIdUseCase {}

class MockNetworkMonitor extends Mock implements NetworkMonitor {}

void main() {
  late MockGetInspectionByClientIdUseCase getInspectionByClientIdUseCase;
  late MockGetCachedInspectionByClientIdUseCase
      getCachedInspectionByClientIdUseCase;
  late MockGetCachedWorkOrderByIdUseCase getCachedWorkOrderByIdUseCase;
  late MockNetworkMonitor networkMonitor;
  late InspectionDetailCubit cubit;

  const clientId = 'client-123';

  final sampleInspection = Inspection(
    clientId: clientId,
    workOrderId: 'wo_1001',
    workOrderCode: 'OS-2026-001',
    status: InspectionSyncStatus.synced,
    notes: 'Inspeção sincronizada',
    createdAt: DateTime.parse('2026-07-26T12:00:00.000Z'),
    updatedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
    syncedAt: DateTime.parse('2026-07-26T13:00:00.000Z'),
  );

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
    getInspectionByClientIdUseCase = MockGetInspectionByClientIdUseCase();
    getCachedInspectionByClientIdUseCase =
        MockGetCachedInspectionByClientIdUseCase();
    getCachedWorkOrderByIdUseCase = MockGetCachedWorkOrderByIdUseCase();
    networkMonitor = MockNetworkMonitor();

    when(() => getCachedInspectionByClientIdUseCase(any()))
        .thenAnswer((_) async => null);
    when(() => getCachedWorkOrderByIdUseCase(any()))
        .thenAnswer((_) async => sampleWorkOrder);
    when(() => networkMonitor.hasInternetAccess())
        .thenAnswer((_) async => true);

    cubit = InspectionDetailCubit(
      getInspectionByClientIdUseCase,
      getCachedInspectionByClientIdUseCase,
      getCachedWorkOrderByIdUseCase,
      networkMonitor,
    );
  });

  tearDown(() => cubit.close());

  blocTest<InspectionDetailCubit, InspectionDetailState>(
    'emits success when inspection is loaded from remote',
    build: () {
      when(() => getInspectionByClientIdUseCase(clientId))
          .thenAnswer((_) async => appSuccess(sampleInspection));
      return cubit;
    },
    act: (cubit) => cubit.load(clientId),
    expect: () => [
      const InspectionDetailState(status: InspectionDetailStatus.loading),
      InspectionDetailState(
        status: InspectionDetailStatus.success,
        inspection: sampleInspection,
        workOrderCode: 'OS-2026-001',
        workOrderTitle: 'Inspeção de poste',
      ),
    ],
  );

  blocTest<InspectionDetailCubit, InspectionDetailState>(
    'shows cached inspection immediately then refreshes when online',
    build: () {
      when(() => getCachedInspectionByClientIdUseCase(clientId))
          .thenAnswer((_) async => sampleInspection);
      when(() => getInspectionByClientIdUseCase(clientId)).thenAnswer(
        (_) async => appSuccess(
          sampleInspection.copyWith(notes: 'Atualizado pela API'),
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.load(clientId),
    expect: () => [
      const InspectionDetailState(status: InspectionDetailStatus.loading),
      InspectionDetailState(
        status: InspectionDetailStatus.success,
        inspection: sampleInspection,
        workOrderCode: 'OS-2026-001',
        workOrderTitle: 'Inspeção de poste',
      ),
      InspectionDetailState(
        status: InspectionDetailStatus.success,
        inspection: sampleInspection.copyWith(notes: 'Atualizado pela API'),
        workOrderCode: 'OS-2026-001',
        workOrderTitle: 'Inspeção de poste',
      ),
    ],
  );

  blocTest<InspectionDetailCubit, InspectionDetailState>(
    'emits failure with network message when offline without cache',
    build: () {
      when(() => networkMonitor.hasInternetAccess())
          .thenAnswer((_) async => false);
      return cubit;
    },
    act: (cubit) => cubit.load(clientId),
    expect: () => [
      const InspectionDetailState(status: InspectionDetailStatus.loading),
      const InspectionDetailState(
        status: InspectionDetailStatus.failure,
        errorMessage: 'Sem conexão com a internet. Tente novamente.',
      ),
    ],
  );

  blocTest<InspectionDetailCubit, InspectionDetailState>(
    'keeps cached inspection when remote refresh fails',
    build: () {
      when(() => getCachedInspectionByClientIdUseCase(clientId))
          .thenAnswer((_) async => sampleInspection);
      when(() => getInspectionByClientIdUseCase(clientId)).thenAnswer(
        (_) async => appFailure(const NetworkFailure()),
      );
      return cubit;
    },
    act: (cubit) => cubit.load(clientId),
    expect: () => [
      const InspectionDetailState(status: InspectionDetailStatus.loading),
      InspectionDetailState(
        status: InspectionDetailStatus.success,
        inspection: sampleInspection,
        workOrderCode: 'OS-2026-001',
        workOrderTitle: 'Inspeção de poste',
      ),
    ],
  );
}
