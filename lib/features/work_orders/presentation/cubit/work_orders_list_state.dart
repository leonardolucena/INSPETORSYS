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
    this.codeSearchQuery = '',
    this.errorMessage,
    this.isRefreshing = false,
  });

  const WorkOrdersListState.initial() : this();

  final WorkOrdersListStatus status;
  final List<WorkOrder> workOrders;
  final WorkOrderStatus? statusFilter;
  final String codeSearchQuery;
  final String? errorMessage;
  final bool isRefreshing;

  List<WorkOrder> get visibleWorkOrders {
    final query = codeSearchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return workOrders;
    }

    return workOrders
        .where((workOrder) => workOrder.code.toLowerCase().contains(query))
        .toList();
  }

  bool get hasActiveCodeSearch => codeSearchQuery.trim().isNotEmpty;

  WorkOrdersListState copyWith({
    WorkOrdersListStatus? status,
    List<WorkOrder>? workOrders,
    WorkOrderStatus? statusFilter,
    String? codeSearchQuery,
    String? errorMessage,
    bool? isRefreshing,
    bool clearStatusFilter = false,
    bool clearErrorMessage = false,
    bool clearCodeSearchQuery = false,
  }) {
    return WorkOrdersListState(
      status: status ?? this.status,
      workOrders: workOrders ?? this.workOrders,
      statusFilter:
          clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
      codeSearchQuery:
          clearCodeSearchQuery ? '' : (codeSearchQuery ?? this.codeSearchQuery),
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
        codeSearchQuery,
        errorMessage,
        isRefreshing,
      ];
}
