import 'package:inspetorsys/features/inspections/domain/entities/sync_queue_item.dart';

abstract interface class SyncQueueLocalDataSource {
  Future<void> enqueueInspection(String inspectionClientId);

  Future<void> removeByInspectionClientId(String inspectionClientId);

  Future<List<SyncQueueItem>> getProcessableItems();

  Future<void> removeById(int id);

  Future<void> markFailed({
    required int id,
    required String errorMessage,
  });

  Future<void> recordNetworkFailure({
    required int id,
    required String errorMessage,
    required int retryCount,
    required DateTime nextRetryAt,
  });
}
