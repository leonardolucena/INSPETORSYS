import 'package:drift/drift.dart';

class InspectionFormSchemasTable extends Table {
  TextColumn get workOrderId => text()();
  TextColumn get schemaJson => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {workOrderId};
}
