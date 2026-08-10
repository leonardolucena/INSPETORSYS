import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';

part 'work_order_dto.freezed.dart';
part 'work_order_dto.g.dart';

@freezed
abstract class WorkOrderDto with _$WorkOrderDto {
  const factory WorkOrderDto({
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
    DateTime? createdAt,
    required DateTime updatedAt,
  }) = _WorkOrderDto;

  factory WorkOrderDto.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderDtoFromJson(json);
}

extension WorkOrderDtoMapper on WorkOrderDto {
  WorkOrder toDomain({DateTime? cachedAt}) {
    return WorkOrder(
      id: id,
      code: code,
      title: title,
      description: description,
      notes: notes,
      address: address,
      priority: priority,
      status: status,
      latitude: latitude,
      longitude: longitude,
      scheduledAt: scheduledAt,
      createdAt: createdAt ?? updatedAt,
      updatedAt: updatedAt,
      cachedAt: cachedAt ?? DateTime.now(),
    );
  }
}
