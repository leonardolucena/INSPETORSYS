import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/repositories/work_order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWorkOrderByIdUseCase {
  GetWorkOrderByIdUseCase(this._repository);

  final WorkOrderRepository _repository;

  AppAsyncResult<WorkOrder> call(String id) {
    return _repository.getWorkOrderById(id);
  }
}
