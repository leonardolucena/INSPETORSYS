import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/domain/repositories/work_order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCachedWorkOrdersUseCase {
  GetCachedWorkOrdersUseCase(this._repository);

  final WorkOrderRepository _repository;

  Future<List<WorkOrder>> call({WorkOrderStatus? status}) {
    return _repository.getCachedWorkOrders(status: status);
  }
}

@injectable
class GetCachedWorkOrderByIdUseCase {
  GetCachedWorkOrderByIdUseCase(this._repository);

  final WorkOrderRepository _repository;

  Future<WorkOrder?> call(String id) {
    return _repository.getCachedWorkOrderById(id);
  }
}
