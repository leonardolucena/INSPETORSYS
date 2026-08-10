import 'package:inspetorsys/core/errors/app_result.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/features/work_orders/domain/repositories/work_order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWorkOrdersUseCase {
  GetWorkOrdersUseCase(this._repository);

  final WorkOrderRepository _repository;

  AppAsyncResult<List<WorkOrder>> call({
    WorkOrderStatus? status,
    bool forceRefresh = false,
  }) {
    return _repository.getWorkOrders(
      status: status,
      forceRefresh: forceRefresh,
    );
  }
}
