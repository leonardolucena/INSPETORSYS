import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/features/inspections/data/datasources/inspection_form_schema_cache_data_source.dart';
import 'package:inspetorsys/features/inspections/data/dto/inspection_form_schema_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InspectionFormSchemaCacheDataSource)
class DriftInspectionFormSchemaCacheDataSource
    implements InspectionFormSchemaCacheDataSource {
  DriftInspectionFormSchemaCacheDataSource(this._database);

  final AppDatabase _database;

  @override
  Future<InspectionFormSchemaDto?> get(String workOrderId) async {
    final row = await (_database.select(_database.inspectionFormSchemasTable)
          ..where((table) => table.workOrderId.equals(workOrderId)))
        .getSingleOrNull();

    if (row == null) {
      return null;
    }

    final json = jsonDecode(row.schemaJson) as Map<String, dynamic>;
    return InspectionFormSchemaDto.fromJson(json);
  }

  @override
  Future<void> save(InspectionFormSchemaDto schema) async {
    await _database.into(_database.inspectionFormSchemasTable).insertOnConflictUpdate(
          InspectionFormSchemasTableCompanion(
            workOrderId: Value(schema.workOrderId),
            schemaJson: Value(jsonEncode(schema.toJson())),
            cachedAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<void> clearAll() {
    return _database.delete(_database.inspectionFormSchemasTable).go();
  }
}
