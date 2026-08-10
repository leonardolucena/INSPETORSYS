import 'package:drift/drift.dart';

class InspectionsTable extends Table {
  TextColumn get clientId => text()();
  TextColumn get serverId => text().nullable()();
  TextColumn get workOrderId => text()();
  TextColumn get workOrderCode => text().nullable()();
  RealColumn get workOrderLatitude => real().nullable()();
  RealColumn get workOrderLongitude => real().nullable()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get capturedAt => dateTime().nullable()();
  TextColumn get formDataJson => text().nullable()();
  TextColumn get formSchemaJson => text().nullable()();
  TextColumn get syncErrorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {clientId};
}
