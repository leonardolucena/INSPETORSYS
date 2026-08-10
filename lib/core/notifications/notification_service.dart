import 'package:inspetorsys/features/sync/domain/entities/inspection_sync_result.dart';

abstract interface class NotificationService {
  Future<void> initialize();

  Future<void> requestPermissionIfNeeded();

  Future<void> showBackgroundSyncResult(InspectionSyncResult result);
}
