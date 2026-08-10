import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';

abstract interface class WorkOrderLocalDataSource {
  Future<List<WorkOrder>> getWorkOrders({WorkOrderStatus? status});

  Future<WorkOrder?> getWorkOrderById(String id);

  Future<void> replaceAll(List<WorkOrder> workOrders);

  Future<void> upsert(WorkOrder workOrder);
}
