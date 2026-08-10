import 'package:equatable/equatable.dart';
import 'package:inspetorsys/features/sync/domain/entities/inspection_sync_result.dart';

enum SyncOperationStatus {
  idle,
  syncing,
  offline,
}

class SyncState extends Equatable {
  const SyncState({
    this.operationStatus = SyncOperationStatus.idle,
    this.isManualTrigger = false,
    this.feedbackMessage,
    this.isSuccessFeedback = false,
    this.lastResult,
    this.pendingCount = 0,
  });

  final SyncOperationStatus operationStatus;
  final bool isManualTrigger;
  final String? feedbackMessage;
  final bool isSuccessFeedback;
  final InspectionSyncResult? lastResult;
  final int pendingCount;

  bool get isSyncing => operationStatus == SyncOperationStatus.syncing;
  bool get hasPendingItems => pendingCount > 0;

  SyncState copyWith({
    SyncOperationStatus? operationStatus,
    bool? isManualTrigger,
    String? feedbackMessage,
    bool? isSuccessFeedback,
    InspectionSyncResult? lastResult,
    int? pendingCount,
    bool clearFeedback = false,
    bool clearLastResult = false,
  }) {
    return SyncState(
      operationStatus: operationStatus ?? this.operationStatus,
      isManualTrigger: isManualTrigger ?? this.isManualTrigger,
      feedbackMessage:
          clearFeedback ? null : (feedbackMessage ?? this.feedbackMessage),
      isSuccessFeedback: isSuccessFeedback ?? this.isSuccessFeedback,
      lastResult: clearLastResult ? null : (lastResult ?? this.lastResult),
      pendingCount: pendingCount ?? this.pendingCount,
    );
  }

  @override
  List<Object?> get props => [
        operationStatus,
        isManualTrigger,
        feedbackMessage,
        isSuccessFeedback,
        lastResult,
        pendingCount,
      ];
}
