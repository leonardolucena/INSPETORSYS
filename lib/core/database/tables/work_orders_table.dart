import 'package:drift/drift.dart';

class WorkOrdersTable extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get address => text()();
  TextColumn get priority => text()();
  TextColumn get status => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get scheduledAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
