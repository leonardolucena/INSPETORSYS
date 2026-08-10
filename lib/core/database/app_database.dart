import 'package:drift/drift.dart';
import 'package:inspetorsys/core/database/database_connection.dart';
import 'package:inspetorsys/core/database/tables/inspection_form_schemas_table.dart';
import 'package:inspetorsys/core/database/tables/inspections_table.dart';
import 'package:inspetorsys/core/database/tables/sync_queue_table.dart';
import 'package:inspetorsys/core/database/tables/work_orders_table.dart';
import 'package:inspetorsys/core/storage/app_paths.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    WorkOrdersTable,
    InspectionsTable,
    SyncQueueTable,
    InspectionFormSchemasTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(AppPaths appPaths) : super(openDatabaseConnection(appPaths));

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(
              workOrdersTable,
              workOrdersTable.description,
            );
          }
          if (from < 3) {
            await migrator.addColumn(
              workOrdersTable,
              workOrdersTable.notes,
            );
          }
          if (from < 4) {
            await migrator.createTable(inspectionFormSchemasTable);
          }
          if (from < 5) {
            await migrator.addColumn(
              inspectionsTable,
              inspectionsTable.workOrderCode,
            );
            await migrator.addColumn(
              inspectionsTable,
              inspectionsTable.workOrderLatitude,
            );
            await migrator.addColumn(
              inspectionsTable,
              inspectionsTable.workOrderLongitude,
            );
            await migrator.addColumn(
              inspectionsTable,
              inspectionsTable.formSchemaJson,
            );
          }
          if (from < 6) {
            await migrator.addColumn(
              inspectionsTable,
              inspectionsTable.capturedAt,
            );
          }
        },
      );

  /// Removes API-cached data tied to the authenticated session.
  /// Local inspections and sync queue are preserved across logout/relogin.
  Future<void> clearSensitiveSessionData() async {
    await delete(workOrdersTable).go();
    await delete(inspectionFormSchemasTable).go();
  }
}
