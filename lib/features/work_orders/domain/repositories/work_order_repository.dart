import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';

abstract interface class WorkOrderRepository {
  Future<List<WorkOrder>> getCachedWorkOrders({WorkOrderStatus? status});

  Future<WorkOrder?> getCachedWorkOrderById(String id);

  AppAsyncResult<List<WorkOrder>> getWorkOrders({
    WorkOrderStatus? status,
    bool forceRefresh = false,
  });

  AppAsyncResult<WorkOrder> getWorkOrderById(String id);

  AppAsyncResult<InspectionFormSchema> getInspectionFormSchema(String workOrderId);
}
