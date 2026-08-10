import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/failure_message_mapper.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_cached_inspections_use_case.dart';
import 'package:inspetorsys/features/inspections/domain/usecases/get_inspection_by_client_id_use_case.dart';
import 'package:inspetorsys/features/inspections/presentation/cubit/inspection_detail_state.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_cached_work_orders_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class InspectionDetailCubit extends Cubit<InspectionDetailState> {
  InspectionDetailCubit(
    this._getInspectionByClientIdUseCase,
    this._getCachedInspectionByClientIdUseCase,
    this._getCachedWorkOrderByIdUseCase,
    this._networkMonitor,
  ) : super(const InspectionDetailState.initial());

  final GetInspectionByClientIdUseCase _getInspectionByClientIdUseCase;
  final GetCachedInspectionByClientIdUseCase
      _getCachedInspectionByClientIdUseCase;
  final GetCachedWorkOrderByIdUseCase _getCachedWorkOrderByIdUseCase;
  final NetworkMonitor _networkMonitor;

  Future<void> load(String clientId) async {
    emit(
      state.copyWith(
        status: InspectionDetailStatus.loading,
        clearErrorMessage: true,
      ),
    );

    final cached = await _getCachedInspectionByClientIdUseCase(clientId);

    if (isClosed) {
      return;
    }

    if (cached != null) {
      await _emitSuccess(cached);
    }

    final hasInternet = await _networkMonitor.hasInternetAccess();
    if (!hasInternet) {
      if (cached == null) {
        emit(
          state.copyWith(
            status: InspectionDetailStatus.failure,
            errorMessage: mapFailureToUserMessage(
              const NetworkFailure(),
              context: FailureMessageContext.inspectionHistory,
            ),
          ),
        );
      }
      return;
    }

    final result = await _getInspectionByClientIdUseCase(clientId);

    if (isClosed) {
      return;
    }

    await result.fold(
      (inspection) async => _emitSuccess(inspection),
      (failure) async {
        if (cached != null) {
          return;
        }

        emit(
          state.copyWith(
            status: InspectionDetailStatus.failure,
            errorMessage: mapFailureToUserMessage(
              failure,
              context: FailureMessageContext.inspectionHistory,
            ),
          ),
        );
      },
    );
  }

  Future<void> _emitSuccess(Inspection inspection) async {
    final workOrder =
        await _getCachedWorkOrderByIdUseCase(inspection.workOrderId);

    if (isClosed) {
      return;
    }

    emit(
      state.copyWith(
        status: InspectionDetailStatus.success,
        inspection: inspection,
        workOrderCode: workOrder?.code ?? inspection.workOrderCode,
        workOrderTitle: workOrder?.title,
        clearErrorMessage: true,
      ),
    );
  }
}
