import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection_form_schema.dart';
import 'package:inspetorsys/features/work_orders/domain/repositories/work_order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInspectionFormSchemaUseCase {
  GetInspectionFormSchemaUseCase(this._workOrderRepository);

  final WorkOrderRepository _workOrderRepository;

  AppAsyncResult<InspectionFormSchema> call(String workOrderId) {
    return _workOrderRepository.getInspectionFormSchema(workOrderId);
  }
}
