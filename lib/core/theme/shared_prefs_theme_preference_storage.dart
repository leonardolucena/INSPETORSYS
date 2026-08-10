import 'package:flutter/material.dart';
import 'package:inspetorsys/core/theme/theme_preference_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ThemePreferenceStorage)
class SharedPrefsThemePreferenceStorage implements ThemePreferenceStorage {
  SharedPrefsThemePreferenceStorage(this._preferences);

  static const _themeModeKey = 'theme_mode';

  final SharedPreferences _preferences;

  @override
  ThemeMode? readThemeMode() {
    return switch (_preferences.getString(_themeModeKey)) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => null,
    };
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) {
    final value = switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.light => 'light',
      ThemeMode.system => 'light',
    };

    return _preferences.setString(_themeModeKey, value);
  }
}
