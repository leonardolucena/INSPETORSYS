import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';

enum WorkOrdersListStatus {
  initial,
  loading,
  success,
  empty,
  failure,
}

class WorkOrdersListState extends Equatable {
  const WorkOrdersListState({
    this.status = WorkOrdersListStatus.initial,
    this.workOrders = const [],
    this.statusFilter,
    this.errorMessage,
    this.isRefreshing = false,
  });

  const WorkOrdersListState.initial() : this();

  final WorkOrdersListStatus status;
  final List<WorkOrder> workOrders;
  final WorkOrderStatus? statusFilter;
  final String? errorMessage;
  final bool isRefreshing;

  WorkOrdersListState copyWith({
    WorkOrdersListStatus? status,
    List<WorkOrder>? workOrders,
    WorkOrderStatus? statusFilter,
    String? errorMessage,
    bool? isRefreshing,
    bool clearStatusFilter = false,
    bool clearErrorMessage = false,
  }) {
    return WorkOrdersListState(
      status: status ?? this.status,
      workOrders: workOrders ?? this.workOrders,
      statusFilter:
          clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        status,
        workOrders,
        statusFilter,
        errorMessage,
        isRefreshing,
      ];
}
