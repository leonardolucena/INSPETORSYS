import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/connectivity/network_status.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_pending_inspections_count_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/prefetch_inspections_use_case.dart';
import 'package:inspetorsys/features/sync/domain/entities/inspection_sync_result.dart';
import 'package:inspetorsys/features/sync/domain/usecases/sync_pending_inspections_use_case.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/prefetch_work_orders_use_case.dart';
import 'package:inspetorsys/features/sync/presentation/cubit/sync_state.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncCubit extends Cubit<SyncState> {
  SyncCubit(
    this._syncPendingInspectionsUseCase,
    this._getPendingInspectionsCountUseCase,
    this._prefetchWorkOrdersUseCase,
    this._prefetchInspectionsUseCase,
    this._networkMonitor,
  ) : super(const SyncState());

  final SyncPendingInspectionsUseCase _syncPendingInspectionsUseCase;
  final GetPendingInspectionsCountUseCase _getPendingInspectionsCountUseCase;
  final PrefetchWorkOrdersUseCase _prefetchWorkOrdersUseCase;
  final PrefetchInspectionsUseCase _prefetchInspectionsUseCase;
  final NetworkMonitor _networkMonitor;

  StreamSubscription<NetworkStatus>? _connectivitySubscription;
  NetworkStatus? _lastNetworkStatus;
  var _autoSyncEnabled = false;

  void startAutoSync() {
    if (_autoSyncEnabled) {
      return;
    }

    _autoSyncEnabled = true;
    _connectivitySubscription = _networkMonitor.onStatusChanged.listen(
      _handleNetworkStatusChanged,
    );

    unawaited(_networkMonitor.getStatus().then(_handleNetworkStatusChanged));
    unawaited(refreshPendingCount());
  }

  Future<void> refreshPendingCount() async {
    final result = await _getPendingInspectionsCountUseCase();
    result.fold(
      (count) => emit(state.copyWith(pendingCount: count)),
      (_) {},
    );
  }

  void stopAutoSync() {
    _autoSyncEnabled = false;
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    _lastNetworkStatus = null;
  }

  Future<void> syncNow({bool isAutomatic = false}) async {
    if (state.isSyncing) {
      return;
    }

    final hasInternet = await _networkMonitor.hasInternetAccess();
    if (!hasInternet) {
      if (!isAutomatic) {
        emit(
          state.copyWith(
            operationStatus: SyncOperationStatus.offline,
            isManualTrigger: true,
            feedbackMessage: 'Sem conexão com a internet.',
            isSuccessFeedback: false,
          ),
        );
    emit(
      state.copyWith(
        operationStatus: SyncOperationStatus.idle,
        isManualTrigger: false,
        clearFeedback: true,
      ),
    );
      }
      return;
    }

    emit(
      state.copyWith(
        operationStatus: SyncOperationStatus.syncing,
        isManualTrigger: !isAutomatic,
        clearFeedback: true,
      ),
    );

    final result = await _syncPendingInspectionsUseCase();
    final feedback = _buildFeedbackMessage(result);

    emit(
      state.copyWith(
        operationStatus: SyncOperationStatus.idle,
        isManualTrigger: false,
        feedbackMessage: isAutomatic ? null : feedback.message,
        isSuccessFeedback: feedback.isSuccess,
        lastResult: result,
      ),
    );
    await refreshPendingCount();
    unawaited(_prefetchWorkOrdersUseCase());
    unawaited(_prefetchInspectionsUseCase());
  }

  void _handleNetworkStatusChanged(NetworkStatus status) {
    if (!_autoSyncEnabled) {
      return;
    }

    final previousStatus = _lastNetworkStatus;
    _lastNetworkStatus = status;

    if (previousStatus == null) {
      return;
    }

    final recoveredConnectivity =
        status == NetworkStatus.online && previousStatus != NetworkStatus.online;

    if (recoveredConnectivity) {
      unawaited(syncNow(isAutomatic: true));
    }
  }

  _SyncFeedback _buildFeedbackMessage(InspectionSyncResult result) {
    if (result.processed == 0) {
      return const _SyncFeedback(
        message: 'Nenhuma inspeção pendente para sincronizar.',
        isSuccess: true,
      );
    }

    if (result.synced > 0) {
      final suffix = result.synced == 1 ? 'inspeção sincronizada' : 'inspeções sincronizadas';
      return _SyncFeedback(
        message: '${result.synced} $suffix.',
        isSuccess: true,
      );
    }

    if (result.markedFailed > 0) {
      return const _SyncFeedback(
        message: 'Algumas inspeções falharam ao sincronizar.',
        isSuccess: false,
      );
    }

    return const _SyncFeedback(
      message: 'Sincronização em andamento. Tente novamente em instantes.',
      isSuccess: false,
    );
  }

  @override
  Future<void> close() {
    stopAutoSync();
    return super.close();
  }
}

class _SyncFeedback {
  const _SyncFeedback({
    required this.message,
    required this.isSuccess,
  });

  final String message;
  final bool isSuccess;
}
