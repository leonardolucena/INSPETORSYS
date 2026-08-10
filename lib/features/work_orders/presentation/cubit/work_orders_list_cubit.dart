import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/connectivity/network_monitor.dart';
import 'package:inspetorsys/core/errors/app_failure.dart';
import 'package:inspetorsys/core/errors/failure_message_mapper.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_cached_work_orders_use_case.dart';
import 'package:inspetorsys/features/work_orders/domain/usecases/get_work_orders_use_case.dart';
import 'package:inspetorsys/features/work_orders/presentation/cubit/work_orders_list_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkOrdersListCubit extends Cubit<WorkOrdersListState> {
  WorkOrdersListCubit(
    this._getWorkOrdersUseCase,
    this._getCachedWorkOrdersUseCase,
    this._networkMonitor,
  ) : super(const WorkOrdersListState.initial());

  final GetWorkOrdersUseCase _getWorkOrdersUseCase;
  final GetCachedWorkOrdersUseCase _getCachedWorkOrdersUseCase;
  final NetworkMonitor _networkMonitor;

  Future<void> load() async {
    emit(
      state.copyWith(
        status: WorkOrdersListStatus.loading,
        clearErrorMessage: true,
      ),
    );

    await _fetchWorkOrders();
  }

  Future<void> refresh() async {
    if (state.isRefreshing) {
      return;
    }

    emit(state.copyWith(isRefreshing: true, clearErrorMessage: true));

    final hasInternet = await _networkMonitor.hasInternetAccess();
    if (!hasInternet) {
      final cached = await _getCachedWorkOrdersUseCase(
        status: state.statusFilter,
      );

      if (isClosed) {
        return;
      }

      if (cached.isNotEmpty) {
        emit(
          state.copyWith(
            status: cached.isEmpty
                ? WorkOrdersListStatus.empty
                : WorkOrdersListStatus.success,
            workOrders: cached,
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
            context: FailureMessageContext.workOrders,
          ),
        ),
      );
      return;
    }

    final result = await _getWorkOrdersUseCase(
      status: state.statusFilter,
      forceRefresh: true,
    );

    if (isClosed) {
      return;
    }

    result.fold(
      (workOrders) => emit(
        state.copyWith(
          status: workOrders.isEmpty
              ? WorkOrdersListStatus.empty
              : WorkOrdersListStatus.success,
          workOrders: workOrders,
          isRefreshing: false,
          clearErrorMessage: true,
        ),
      ),
      (failure) => emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage: mapFailureToUserMessage(
            failure,
            context: FailureMessageContext.workOrders,
          ),
        ),
      ),
    );
  }

  Future<void> setStatusFilter(WorkOrderStatus? status) async {
    if (state.statusFilter == status) {
      return;
    }

    emit(
      state.copyWith(
        statusFilter: status,
        clearStatusFilter: status == null,
        status: WorkOrdersListStatus.loading,
        clearErrorMessage: true,
      ),
    );

    await _fetchWorkOrders();
  }

  Future<void> _fetchWorkOrders() async {
    final cached = await _getCachedWorkOrdersUseCase(
      status: state.statusFilter,
    );

    if (isClosed) {
      return;
    }

    if (cached.isNotEmpty) {
      emit(
        state.copyWith(
          status: WorkOrdersListStatus.success,
          workOrders: cached,
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
            status: WorkOrdersListStatus.failure,
            isRefreshing: false,
            errorMessage: mapFailureToUserMessage(
              const NetworkFailure(),
              context: FailureMessageContext.workOrders,
            ),
          ),
        );
      }
      return;
    }

    final result = await _getWorkOrdersUseCase(
      status: state.statusFilter,
    );

    if (isClosed) {
      return;
    }

    result.fold(
      (workOrders) => emit(
        state.copyWith(
          status: workOrders.isEmpty
              ? WorkOrdersListStatus.empty
              : WorkOrdersListStatus.success,
          workOrders: workOrders,
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
            status: WorkOrdersListStatus.failure,
            isRefreshing: false,
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
