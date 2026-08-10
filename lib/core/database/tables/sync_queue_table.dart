import 'package:drift/drift.dart';

class SyncQueueTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get inspectionClientId => text()();
  TextColumn get status => text()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  DateTimeColumn get nextRetryAt => dateTime().nullable()();
  TextColumn get lastErrorMessage => text().nullable()();
}
