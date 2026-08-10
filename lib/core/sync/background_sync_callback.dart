import 'package:flutter/widgets.dart';
import 'package:inspetorsys/core/di/injection.dart';
import 'package:inspetorsys/core/notifications/notification_service.dart';
import 'package:inspetorsys/core/sync/background_sync_constants.dart';
import 'package:inspetorsys/features/sync/domain/usecases/sync_pending_inspections_use_case.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void backgroundSyncCallbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName != BackgroundSyncConstants.taskName) {
      return false;
    }

    try {
      await _ensureDependenciesConfigured();
      final result = await getIt<SyncPendingInspectionsUseCase>()();

      if (result.synced > 0 || result.markedFailed > 0) {
        await getIt<NotificationService>().showBackgroundSyncResult(result);
      }

      return true;
    } catch (_) {
      return false;
    }
  });
}

Future<void> _ensureDependenciesConfigured() async {
  if (getIt.isRegistered<SyncPendingInspectionsUseCase>()) {
    return;
  }

  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
}
