import 'package:flutter/material.dart';
import 'package:inspetorsys/core/locale/locale_preference_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: LocalePreferenceStorage)
class SharedPrefsLocalePreferenceStorage implements LocalePreferenceStorage {
  SharedPrefsLocalePreferenceStorage(this._preferences);

  static const _localeKey = 'app_locale';

  final SharedPreferences _preferences;

  @override
  Locale? readLocale() {
    return switch (_preferences.getString(_localeKey)) {
      'en' => const Locale('en'),
      'pt' => const Locale('pt'),
      _ => null,
    };
  }

  @override
  Future<void> saveLocale(Locale locale) {
    final value = switch (locale.languageCode) {
      'en' => 'en',
      _ => 'pt',
    };

    return _preferences.setString(_localeKey, value);
  }
}
