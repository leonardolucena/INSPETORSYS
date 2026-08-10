import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_queue_item.freezed.dart';

@freezed
abstract class SyncQueueItem with _$SyncQueueItem {
  const factory SyncQueueItem({
    required int id,
    required String inspectionClientId,
    required String status,
    required int retryCount,
    DateTime? lastAttemptAt,
    DateTime? nextRetryAt,
    String? lastErrorMessage,
  }) = _SyncQueueItem;
}
