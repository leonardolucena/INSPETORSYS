import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/failure_message_mapper.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_cached_inspections_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_inspections_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/retry_failed_inspection_use_case.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspections_list_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class InspectionsListCubit extends Cubit<InspectionsListState> {
  InspectionsListCubit(
    this._getInspectionsUseCase,
    this._getCachedInspectionsUseCase,
    this._retryFailedInspectionUseCase,
    this._networkMonitor,
  ) : super(const InspectionsListState.initial());

  final GetInspectionsUseCase _getInspectionsUseCase;
  final GetCachedInspectionsUseCase _getCachedInspectionsUseCase;
  final RetryFailedInspectionUseCase _retryFailedInspectionUseCase;
  final NetworkMonitor _networkMonitor;

  Future<void> load() async {
    emit(
      state.copyWith(
        status: InspectionsListStatus.loading,
        clearErrorMessage: true,
      ),
    );

    await _fetchInspections();
  }

  Future<void> refresh() async {
    if (state.isRefreshing) {
      return;
    }

    emit(state.copyWith(isRefreshing: true, clearErrorMessage: true));

    final hasInternet = await _networkMonitor.hasInternetAccess();
    if (!hasInternet) {
      final cached = await _getCachedInspectionsUseCase(
        status: state.statusFilter,
      );

      if (isClosed) {
        return;
      }

      if (cached.isNotEmpty) {
        emit(
          state.copyWith(
            status: cached.isEmpty
                ? InspectionsListStatus.empty
                : InspectionsListStatus.success,
            inspections: cached,
            isRefreshing: false,
            clearErrorMessage: true,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage: mapFailureToUserMessage(
            const NetworkFailure(),
            context: FailureMessageContext.inspectionHistory,
          ),
        ),
      );
      return;
    }

    final result = await _getInspectionsUseCase(
      status: state.statusFilter,
      forceRefresh: true,
    );

    if (isClosed) {
      return;
    }

    result.fold(
      (inspections) => emit(
        state.copyWith(
          status: inspections.isEmpty
              ? InspectionsListStatus.empty
              : InspectionsListStatus.success,
          inspections: inspections,
          isRefreshing: false,
          clearErrorMessage: true,
        ),
      ),
      (failure) => emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage: mapFailureToUserMessage(
            failure,
            context: FailureMessageContext.inspectionHistory,
          ),
        ),
      ),
    );
  }

  Future<void> setStatusFilter(InspectionSyncStatus? status) async {
    if (state.statusFilter == status) {
      return;
    }

    emit(
      state.copyWith(
        statusFilter: status,
        clearStatusFilter: status == null,
        status: InspectionsListStatus.loading,
        clearErrorMessage: true,
      ),
    );

    await _fetchInspections();
  }

  void setCodeSearchQuery(String query) {
    if (state.codeSearchQuery == query) {
      return;
    }

    emit(state.copyWith(codeSearchQuery: query));
  }

  Future<bool> retryInspection(String clientId) async {
    if (state.retryingClientId != null) {
      return false;
    }

    emit(
      state.copyWith(
        retryingClientId: clientId,
        clearActionFeedback: true,
      ),
    );

    final result = await _retryFailedInspectionUseCase(clientId);

    if (result.isSuccess()) {
      emit(
        state.copyWith(
          clearRetryingClientId: true,
          actionFeedbackMessage: 'Inspeção reenviada para sincronização.',
          actionFeedbackSuccess: true,
        ),
      );
      await _fetchInspections();
      return true;
    }

    final failureMessage = result.fold(
      (_) => 'Não foi possível reenviar a inspeção.',
      (failure) => failure.message,
    );

    emit(
      state.copyWith(
        clearRetryingClientId: true,
        actionFeedbackMessage: failureMessage,
        actionFeedbackSuccess: false,
      ),
    );
    return false;
  }

  void clearActionFeedback() {
    if (state.actionFeedbackMessage == null) {
      return;
    }

    emit(state.copyWith(clearActionFeedback: true));
  }

  Future<void> _fetchInspections() async {
    final cached = await _getCachedInspectionsUseCase(
      status: state.statusFilter,
    );

    if (isClosed) {
      return;
    }

    if (cached.isNotEmpty) {
      emit(
        state.copyWith(
          status: InspectionsListStatus.success,
          inspections: cached,
          isRefreshing: false,
          clearErrorMessage: true,
        ),
      );
    }

    final hasInternet = await _networkMonitor.hasInternetAccess();
    if (!hasInternet) {
      if (cached.isEmpty) {
        emit(
          state.copyWith(
            status: InspectionsListStatus.failure,
            isRefreshing: false,
            errorMessage: mapFailureToUserMessage(
              const NetworkFailure(),
              context: FailureMessageContext.inspectionHistory,
            ),
          ),
        );
      }
      return;
    }

    final result = await _getInspectionsUseCase(
      status: state.statusFilter,
    );

    if (isClosed) {
      return;
    }

    result.fold(
      (inspections) => emit(
        state.copyWith(
          status: inspections.isEmpty
              ? InspectionsListStatus.empty
              : InspectionsListStatus.success,
          inspections: inspections,
          isRefreshing: false,
          clearErrorMessage: true,
        ),
      ),
      (failure) {
        if (cached.isNotEmpty) {
          return;
        }

        emit(
          state.copyWith(
            status: InspectionsListStatus.failure,
            isRefreshing: false,
            errorMessage: mapFailureToUserMessage(
              failure,
              context: FailureMessageContext.inspectionHistory,
            ),
          ),
        );
      },
    );
  }
}
