import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspetorsys/core/theme/theme_preference_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._themePreferenceStorage) : super(ThemeMode.light);

  final ThemePreferenceStorage _themePreferenceStorage;

  Future<void> load() async {
    final savedThemeMode = _themePreferenceStorage.readThemeMode();
    if (savedThemeMode != null) {
      emit(savedThemeMode);
    }
  }

  Future<void> setDarkMode(bool isDark) async {
    final themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await _themePreferenceStorage.saveThemeMode(themeMode);
    emit(themeMode);
  }

  bool get isDarkMode => state == ThemeMode.dark;
}
