import 'package:inspetorsys/features/inspections/data/dto/inspection_form_schema_dto.dart';
import 'package:inspetorsys/features/work_orders/data/dto/work_order_dto.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';

abstract interface class WorkOrderRemoteDataSource {
  Future<List<WorkOrderDto>> fetchWorkOrders({WorkOrderStatus? status});

  Future<WorkOrderDto> fetchWorkOrderById(String id);

  Future<InspectionFormSchemaDto> fetchInspectionFormSchema(String workOrderId);
}
