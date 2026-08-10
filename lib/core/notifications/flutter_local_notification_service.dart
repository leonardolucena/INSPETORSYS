import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inspetorsys/core/locale/locale_preference_storage.dart';
import 'package:inspetorsys/core/locale/localized_labels.dart';
import 'package:inspetorsys/core/notifications/notification_service.dart';
import 'package:inspetorsys/features/sync/domain/entities/inspection_sync_result.dart';
import 'package:inspetorsys/l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationService)
class FlutterLocalNotificationService implements NotificationService {
  FlutterLocalNotificationService(this._localePreferenceStorage);

  static const _channelId = 'background_sync';
  static const _notificationId = 1;

  final LocalePreferenceStorage _localePreferenceStorage;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  var _isInitialized = false;

  @override
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );

    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelId,
          'InspetorSYS sync',
          description: 'Background inspection sync results',
          importance: Importance.defaultImportance,
        ),
      );
    }

    _isInitialized = true;
  }

  @override
  Future<void> requestPermissionIfNeeded() async {
    await initialize();

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  Future<void> showBackgroundSyncResult(InspectionSyncResult result) async {
    if (result.synced == 0 && result.markedFailed == 0) {
      return;
    }

    await initialize();

    final l10n = _resolveLocalizations();
    final title = l10n.appTitle;
    final body = localizedSyncFeedback(l10n, result);

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      'InspetorSYS sync',
      channelDescription: 'Background inspection sync results',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id: _notificationId,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  AppLocalizations _resolveLocalizations() {
    final locale = _localePreferenceStorage.readLocale() ?? const Locale('pt');
    return lookupAppLocalizations(locale);
  }
}
