import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/failure_message_mapper.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_cached_work_orders_use_case.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_work_order_by_id_use_case.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_order_detail_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkOrderDetailCubit extends Cubit<WorkOrderDetailState> {
  WorkOrderDetailCubit(
    this._getWorkOrderByIdUseCase,
    this._getCachedWorkOrderByIdUseCase,
    this._networkMonitor,
  ) : super(const WorkOrderDetailState.initial());

  final GetWorkOrderByIdUseCase _getWorkOrderByIdUseCase;
  final GetCachedWorkOrderByIdUseCase _getCachedWorkOrderByIdUseCase;
  final NetworkMonitor _networkMonitor;

  Future<void> load(String id) async {
    emit(
      state.copyWith(
        status: WorkOrderDetailStatus.loading,
        clearErrorMessage: true,
      ),
    );

    final cached = await _getCachedWorkOrderByIdUseCase(id);

    if (isClosed) {
      return;
    }

    if (cached != null) {
      emit(
        state.copyWith(
          status: WorkOrderDetailStatus.success,
          workOrder: cached,
          clearErrorMessage: true,
        ),
      );
    }

    final hasInternet = await _networkMonitor.hasInternetAccess();
    if (!hasInternet) {
      if (cached == null) {
        emit(
          state.copyWith(
            status: WorkOrderDetailStatus.failure,
            errorMessage: mapFailureToUserMessage(
              const NetworkFailure(),
              context: FailureMessageContext.workOrders,
            ),
          ),
        );
      }
      return;
    }

    final result = await _getWorkOrderByIdUseCase(id);

    if (isClosed) {
      return;
    }

    result.fold(
      (workOrder) => emit(
        state.copyWith(
          status: WorkOrderDetailStatus.success,
          workOrder: workOrder,
          clearErrorMessage: true,
        ),
      ),
      (failure) {
        if (cached != null) {
          return;
        }

        emit(
          state.copyWith(
            status: WorkOrderDetailStatus.failure,
            errorMessage: mapFailureToUserMessage(
              failure,
              context: FailureMessageContext.workOrders,
            ),
          ),
        );
      },
    );
  }
}
