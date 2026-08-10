import 'package:flutter/material.dart';

abstract interface class ThemePreferenceStorage {
  ThemeMode? readThemeMode();

  Future<void> saveThemeMode(ThemeMode mode);
}
