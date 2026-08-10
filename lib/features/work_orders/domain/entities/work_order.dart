import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';

part 'work_order.freezed.dart';

@freezed
abstract class WorkOrder with _$WorkOrder {
  const factory WorkOrder({
    required String id,
    required String code,
    required String title,
    String? description,
    String? notes,
    required String address,
    required WorkOrderPriority priority,
    required WorkOrderStatus status,
    double? latitude,
    double? longitude,
    DateTime? scheduledAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? cachedAt,
  }) = _WorkOrder;
}
