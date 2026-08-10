import 'package:drift/drift.dart';
import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/features/inspections/data/datasources/sync_queue_local_data_source.dart';
import 'package:inspetorsys/features/inspections/data/mappers/sync_queue_local_mapper.dart';
import 'package:inspetorsys/features/inspections/domain/constants/sync_queue_constants.dart';
import 'package:inspetorsys/features/inspections/domain/entities/sync_queue_item.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SyncQueueLocalDataSource)
class SyncQueueLocalDataSourceImpl implements SyncQueueLocalDataSource {
  SyncQueueLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> enqueueInspection(String inspectionClientId) async {
    await (_database.delete(_database.syncQueueTable)
          ..where((table) => table.inspectionClientId.equals(inspectionClientId)))
        .go();

    await _database.into(_database.syncQueueTable).insert(
          SyncQueueTableCompanion.insert(
            inspectionClientId: inspectionClientId,
            status: SyncQueueConstants.statusPending,
            retryCount: const Value(0),
          ),
        );
  }

  @override
  Future<void> removeByInspectionClientId(String inspectionClientId) async {
    await (_database.delete(_database.syncQueueTable)
          ..where((table) => table.inspectionClientId.equals(inspectionClientId)))
        .go();
  }

  @override
  Future<List<SyncQueueItem>> getProcessableItems() async {
    final now = DateTime.now();
    final rows = await (_database.select(_database.syncQueueTable)
          ..where(
            (table) =>
                table.status.equals(SyncQueueConstants.statusPending) &
                (table.nextRetryAt.isNull() |
                    table.nextRetryAt.isSmallerOrEqualValue(now)),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.id)]))
        .get();

    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<void> removeById(int id) async {
    await (_database.delete(_database.syncQueueTable)
          ..where((table) => table.id.equals(id)))
        .go();
  }

  @override
  Future<void> markFailed({
    required int id,
    required String errorMessage,
  }) async {
    await (_database.update(_database.syncQueueTable)
          ..where((table) => table.id.equals(id)))
        .write(
      SyncQueueTableCompanion(
        status: const Value(SyncQueueConstants.statusFailed),
        lastAttemptAt: Value(DateTime.now()),
        lastErrorMessage: Value(errorMessage),
      ),
    );
  }

  @override
  Future<void> recordNetworkFailure({
    required int id,
    required String errorMessage,
    required int retryCount,
    required DateTime nextRetryAt,
  }) async {
    await (_database.update(_database.syncQueueTable)
          ..where((table) => table.id.equals(id)))
        .write(
      SyncQueueTableCompanion(
        status: const Value(SyncQueueConstants.statusPending),
        retryCount: Value(retryCount),
        lastAttemptAt: Value(DateTime.now()),
        nextRetryAt: Value(nextRetryAt),
        lastErrorMessage: Value(errorMessage),
      ),
    );
  }
}
