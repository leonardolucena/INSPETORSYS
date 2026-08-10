import 'package:flutter/material.dart';
import 'package:inspetorsys/constants/app_assets.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:inspetorsys/theme/app_text_theme.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppFonts.montserrat,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.secondTextColorLight,
        onPrimary: AppColors.backgroundCardLight,
        secondary: AppColors.secondTextColorLight,
        onSecondary: AppColors.primaryTextColorLight,
        surface: AppColors.backgroundCardLight,
        onSurface: AppColors.primaryTextColorLight,
        error: AppColors.borderError,
        onError: AppColors.primaryTextColorDark,
        errorContainer: AppColors.backgroundError,
        onErrorContainer: AppColors.borderError,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundCardLight,
        foregroundColor: AppColors.primaryTextColorLight,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.backgroundCardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondTextColorLight,
        foregroundColor: AppColors.backgroundCardLight,
      ),
      textTheme: AppTextTheme.light,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundCardLight,
        errorStyle: AppTextTheme.error,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderError),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderError),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppFonts.montserrat,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.secondTextColorDark,
        onPrimary: AppColors.primaryTextColorDark,
        secondary: AppColors.secondTextColorDark,
        onSecondary: AppColors.primaryTextColorDark,
        tertiary: AppColors.thirdTextColorDark,
        onTertiary: AppColors.primaryTextColorDark,
        surface: AppColors.backgroundCardDark,
        onSurface: AppColors.primaryTextColorDark,
        error: AppColors.borderError,
        onError: AppColors.primaryTextColorDark,
        errorContainer: AppColors.backgroundError,
        onErrorContainer: AppColors.borderError,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundCardDark,
        foregroundColor: AppColors.primaryTextColorDark,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.backgroundCardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.borderCardDark),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondTextColorDark,
        foregroundColor: AppColors.primaryTextColorDark,
      ),
      textTheme: AppTextTheme.dark,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundCardDark,
        errorStyle: AppTextTheme.error,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderError),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderError),
        ),
      ),
    );
  }
}
