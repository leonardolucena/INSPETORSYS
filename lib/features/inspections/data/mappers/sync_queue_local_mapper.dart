import 'package:inspetorsys/core/database/app_database.dart';
import 'package:inspetorsys/features/inspections/domain/entities/sync_queue_item.dart';

extension SyncQueueTableDataMapper on SyncQueueTableData {
  SyncQueueItem toDomain() {
    return SyncQueueItem(
      id: id,
      inspectionClientId: inspectionClientId,
      status: status,
      retryCount: retryCount,
      lastAttemptAt: lastAttemptAt,
      nextRetryAt: nextRetryAt,
      lastErrorMessage: lastErrorMessage,
    );
  }
}
