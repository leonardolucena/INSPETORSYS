import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/errors/failure_message_mapper.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_local_inspections_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/retry_failed_inspection_use_case.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspections_list_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class InspectionsListCubit extends Cubit<InspectionsListState> {
  InspectionsListCubit(
    this._getLocalInspectionsUseCase,
    this._retryFailedInspectionUseCase,
  ) : super(const InspectionsListState.initial());

  final GetLocalInspectionsUseCase _getLocalInspectionsUseCase;
  final RetryFailedInspectionUseCase _retryFailedInspectionUseCase;

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
    await _fetchInspections();
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
    final result = await _getLocalInspectionsUseCase(
      status: state.statusFilter,
    );

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
          status: InspectionsListStatus.failure,
          isRefreshing: false,
          errorMessage: mapFailureToUserMessage(
            failure,
            context: FailureMessageContext.inspectionHistory,
          ),
        ),
      ),
    );
  }
}
