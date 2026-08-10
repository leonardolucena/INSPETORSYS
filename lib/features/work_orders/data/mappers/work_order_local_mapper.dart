import 'package:drift/drift.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';

extension WorkOrderLocalMapper on WorkOrder {
  WorkOrdersTableCompanion toCompanion() {
    return WorkOrdersTableCompanion.insert(
      id: id,
      code: code,
      title: title,
      description: Value(description),
      notes: Value(notes),
      address: address,
      priority: priority.apiValue,
      status: status.apiValue,
      latitude: Value(latitude),
      longitude: Value(longitude),
      scheduledAt: Value(scheduledAt),
      createdAt: createdAt,
      updatedAt: updatedAt,
      cachedAt: cachedAt ?? DateTime.now(),
    );
  }
}

extension WorkOrdersTableDataMapper on WorkOrdersTableData {
  WorkOrder toDomain() {
    return WorkOrder(
      id: id,
      code: code,
      title: title,
      description: description,
      notes: notes,
      address: address,
      priority: WorkOrderPriorityX.fromApiValue(priority),
      status: WorkOrderStatusX.fromApiValue(status),
      latitude: latitude,
      longitude: longitude,
      scheduledAt: scheduledAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      cachedAt: cachedAt,
    );
  }
}
