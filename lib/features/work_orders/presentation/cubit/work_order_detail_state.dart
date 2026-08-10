import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';

enum WorkOrderDetailStatus {
  initial,
  loading,
  success,
  failure,
}

class WorkOrderDetailState extends Equatable {
  const WorkOrderDetailState({
    this.status = WorkOrderDetailStatus.initial,
    this.workOrder,
    this.errorMessage,
  });

  const WorkOrderDetailState.initial() : this();

  final WorkOrderDetailStatus status;
  final WorkOrder? workOrder;
  final String? errorMessage;

  WorkOrderDetailState copyWith({
    WorkOrderDetailStatus? status,
    WorkOrder? workOrder,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return WorkOrderDetailState(
      status: status ?? this.status,
      workOrder: workOrder ?? this.workOrder,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, workOrder, errorMessage];
}
