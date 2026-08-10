import 'package:drift/drift.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/features/work_orders/data/datasources/work_order_local_data_source.dart';
import 'package:inspetorsys/features/work_orders/data/mappers/work_order_local_mapper.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkOrderLocalDataSource)
class WorkOrderLocalDataSourceImpl implements WorkOrderLocalDataSource {
  WorkOrderLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<List<WorkOrder>> getWorkOrders({WorkOrderStatus? status}) async {
    final query = _database.select(_database.workOrdersTable);

    if (status != null) {
      query.where((table) => table.status.equals(status.apiValue));
    }

    query.orderBy([
      (table) => OrderingTerm.desc(table.updatedAt),
    ]);

    final rows = await query.get();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<WorkOrder?> getWorkOrderById(String id) async {
    final row = await (_database.select(_database.workOrdersTable)
          ..where((table) => table.id.equals(id)))
        .getSingleOrNull();

    return row?.toDomain();
  }

  @override
  Future<void> replaceAll(List<WorkOrder> workOrders) async {
    await _database.transaction(() async {
      await _database.delete(_database.workOrdersTable).go();

      if (workOrders.isEmpty) {
        return;
      }

      await _database.batch((batch) {
        batch.insertAll(
          _database.workOrdersTable,
          workOrders.map((workOrder) => workOrder.toCompanion()).toList(),
        );
      });
    });
  }

  @override
  Future<void> upsert(WorkOrder workOrder) async {
    await _database.into(_database.workOrdersTable).insertOnConflictUpdate(
          workOrder.toCompanion(),
        );
  }
}
