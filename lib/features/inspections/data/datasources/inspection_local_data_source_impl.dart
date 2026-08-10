import 'package:drift/drift.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/mappers/inspection_local_mapper.dart';
import 'package:inspetorsys/features/inspections/domain/entities/inspection.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InspectionLocalDataSource)
class InspectionLocalDataSourceImpl implements InspectionLocalDataSource {
  InspectionLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> upsert(Inspection inspection) async {
    await _database.into(_database.inspectionsTable).insertOnConflictUpdate(
          inspection.toCompanion(),
        );
  }

  @override
  Future<Inspection?> getByClientId(String clientId) async {
    final row = await (_database.select(_database.inspectionsTable)
          ..where((table) => table.clientId.equals(clientId)))
        .getSingleOrNull();

    return row?.toDomain();
  }

  @override
  Future<List<Inspection>> list({InspectionSyncStatus? status}) async {
    final query = _database.select(_database.inspectionsTable)
      ..orderBy([(table) => OrderingTerm.desc(table.updatedAt)]);

    if (status != null) {
      query.where((table) => table.status.equals(status.storageValue));
    }

    final rows = await query.get();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<int> countByStatus(InspectionSyncStatus status) async {
    final countExpression = _database.inspectionsTable.clientId.count();
    final query = _database.selectOnly(_database.inspectionsTable)
      ..addColumns([countExpression])
      ..where(
        _database.inspectionsTable.status.equals(status.storageValue),
      );

    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }
}
