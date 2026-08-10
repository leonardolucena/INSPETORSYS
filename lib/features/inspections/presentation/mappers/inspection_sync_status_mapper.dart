import 'package:inspetorsys/components/status_badge.dart';
import 'package:inspetorsys/features/inspections/domain/enums/inspection_sync_status.dart';

extension InspectionSyncStatusPresentationMapper on InspectionSyncStatus {
  AppSyncStatus get badgeStatus => switch (this) {
        InspectionSyncStatus.draft => AppSyncStatus.draft,
        InspectionSyncStatus.pending => AppSyncStatus.pending,
        InspectionSyncStatus.synced => AppSyncStatus.synced,
        InspectionSyncStatus.failed => AppSyncStatus.failed,
      };
}
