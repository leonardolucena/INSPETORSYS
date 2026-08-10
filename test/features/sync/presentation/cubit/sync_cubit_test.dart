import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/connectivity/network_status.dart';
import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/sync/domain/entities/inspection_sync_result.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_pending_inspections_count_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/prefetch_inspections_use_case.dart';
import 'package:inspetorsys/features/sync/domain/usecases/sync_pending_inspections_use_case.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/prefetch_work_orders_use_case.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_cubit.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_state.dart';
import 'package:mocktail/mocktail.dart';

class MockSyncPendingInspectionsUseCase extends Mock
    implements SyncPendingInspectionsUseCase {}

class MockGetPendingInspectionsCountUseCase extends Mock
    implements GetPendingInspectionsCountUseCase {}

class MockNetworkMonitor extends Mock implements NetworkMonitor {}

class MockPrefetchWorkOrdersUseCase extends Mock
    implements PrefetchWorkOrdersUseCase {}

class MockPrefetchInspectionsUseCase extends Mock
    implements PrefetchInspectionsUseCase {}

void main() {
  late MockSyncPendingInspectionsUseCase syncUseCase;
  late MockGetPendingInspectionsCountUseCase pendingCountUseCase;
  late MockPrefetchWorkOrdersUseCase prefetchWorkOrdersUseCase;
  late MockPrefetchInspectionsUseCase prefetchInspectionsUseCase;
  late MockNetworkMonitor networkMonitor;
  late StreamController<NetworkStatus> statusController;
  late SyncCubit cubit;

  setUp(() {
    syncUseCase = MockSyncPendingInspectionsUseCase();
    pendingCountUseCase = MockGetPendingInspectionsCountUseCase();
    prefetchWorkOrdersUseCase = MockPrefetchWorkOrdersUseCase();
    prefetchInspectionsUseCase = MockPrefetchInspectionsUseCase();
    networkMonitor = MockNetworkMonitor();
    statusController = StreamController<NetworkStatus>.broadcast();

    when(() => networkMonitor.onStatusChanged)
        .thenAnswer((_) => statusController.stream);
    when(() => networkMonitor.hasInternetAccess()).thenAnswer((_) async => true);
    when(() => networkMonitor.getStatus())
        .thenAnswer((_) async => NetworkStatus.online);
    when(() => pendingCountUseCase())
        .thenAnswer((_) async => appSuccess(0));
    when(() => prefetchWorkOrdersUseCase()).thenAnswer((_) async {});
    when(() => prefetchInspectionsUseCase()).thenAnswer((_) async {});

    cubit = SyncCubit(
      syncUseCase,
      pendingCountUseCase,
      prefetchWorkOrdersUseCase,
      prefetchInspectionsUseCase,
      networkMonitor,
    );
  });

  tearDown(() async {
    await statusController.close();
    await cubit.close();
  });

  test('initial state is idle', () {
    expect(cubit.state, const SyncState());
  });

  test('refreshPendingCount updates pending count in state', () async {
    when(() => pendingCountUseCase()).thenAnswer((_) async => appSuccess(3));

    await cubit.refreshPendingCount();

    expect(cubit.state.pendingCount, 3);
  });

  blocTest<SyncCubit, SyncState>(
    'syncNow emits feedback when inspections are synced',
    build: () {
      when(() => syncUseCase()).thenAnswer(
        (_) async => const InspectionSyncResult(processed: 1, synced: 1),
      );
      return cubit;
    },
    act: (cubit) => cubit.syncNow(),
    expect: () => [
      const SyncState(
        operationStatus: SyncOperationStatus.syncing,
        isManualTrigger: true,
      ),
      const SyncState(
        feedbackMessage: '1 inspeção sincronizada.',
        isSuccessFeedback: true,
        lastResult: InspectionSyncResult(processed: 1, synced: 1),
      ),
    ],
  );

  blocTest<SyncCubit, SyncState>(
    'syncNow reports offline when there is no internet',
    build: () {
      when(() => networkMonitor.hasInternetAccess())
          .thenAnswer((_) async => false);
      return cubit;
    },
    act: (cubit) => cubit.syncNow(),
    expect: () => [
      const SyncState(
        operationStatus: SyncOperationStatus.offline,
        isManualTrigger: true,
        feedbackMessage: 'Sem conexão com a internet.',
        isSuccessFeedback: false,
      ),
      const SyncState(operationStatus: SyncOperationStatus.idle),
    ],
    verify: (_) {
      verifyNever(() => syncUseCase());
    },
  );

  test('auto sync triggers when connectivity is restored', () async {
    when(() => syncUseCase()).thenAnswer(
      (_) async => const InspectionSyncResult(),
    );

    cubit.startAutoSync();
    statusController.add(NetworkStatus.offline);
    statusController.add(NetworkStatus.online);

    await Future<void>.delayed(Duration.zero);

    verify(() => syncUseCase()).called(1);
  });

  test('auto sync does not show manual feedback', () async {
    when(() => syncUseCase()).thenAnswer(
      (_) async => const InspectionSyncResult(processed: 1, synced: 1),
    );

    cubit.startAutoSync();
    statusController.add(NetworkStatus.offline);
    statusController.add(NetworkStatus.online);

    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.feedbackMessage, isNull);
  });

  test('stopAutoSync prevents connectivity-triggered sync', () async {
    when(() => syncUseCase()).thenAnswer(
      (_) async => const InspectionSyncResult(),
    );

    cubit.startAutoSync();
    cubit.stopAutoSync();
    statusController.add(NetworkStatus.offline);
    statusController.add(NetworkStatus.online);

    await Future<void>.delayed(Duration.zero);

    verifyNever(() => syncUseCase());
  });
}
