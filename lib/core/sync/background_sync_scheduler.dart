import 'package:inspetorsys/core/sync/background_sync_callback.dart';
import 'package:inspetorsys/core/sync/background_sync_constants.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundSyncScheduler {
  const BackgroundSyncScheduler._();

  static Future<void> initialize() {
    return Workmanager().initialize(backgroundSyncCallbackDispatcher);
  }

  static Future<void> registerPeriodicSync({
    Duration frequency = const Duration(hours: 1),
  }) {
    return Workmanager().registerPeriodicTask(
      BackgroundSyncConstants.uniqueName,
      BackgroundSyncConstants.taskName,
      frequency: frequency,
      initialDelay: const Duration(minutes: 15),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  static Future<void> registerOneOffSync() {
    return Workmanager().registerOneOffTask(
      '${BackgroundSyncConstants.uniqueName}_one_off',
      BackgroundSyncConstants.taskName,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  static Future<void> cancelSync() {
    return Workmanager().cancelByUniqueName(BackgroundSyncConstants.uniqueName);
  }
}
