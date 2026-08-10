import 'package:flutter/material.dart';
import 'package:inspetorsys/constants/app_assets.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:inspetorsys/theme/app_contrast_extension.dart';
import 'package:inspetorsys/theme/app_text_theme.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme => _buildTheme(
        brightness: Brightness.light,
        highContrast: false,
      );

  static ThemeData get darkTheme => _buildTheme(
        brightness: Brightness.dark,
        highContrast: false,
      );

  static ThemeData get highContrastLightTheme => _buildTheme(
        brightness: Brightness.light,
        highContrast: true,
      );

  static ThemeData get highContrastDarkTheme => _buildTheme(
        brightness: Brightness.dark,
        highContrast: true,
      );

  static ThemeData resolveTheme({
    required ThemeMode themeMode,
    required bool highContrast,
  }) {
    final isDark = themeMode == ThemeMode.dark;

    if (highContrast) {
      return isDark ? highContrastDarkTheme : highContrastLightTheme;
    }

    return isDark ? darkTheme : lightTheme;
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required bool highContrast,
  }) {
    final isDark = brightness == Brightness.dark;

    final scaffoldBackgroundColor = highContrast
        ? (isDark
            ? AppColors.hcScreenBackgroundDark
            : AppColors.hcScreenBackgroundLight)
        : (isDark ? AppColors.backgroundDark : AppColors.backgroundLight);

    final surfaceColor = highContrast
        ? (isDark
            ? AppColors.hcCardBackgroundDark
            : AppColors.hcCardBackgroundLight)
        : (isDark ? AppColors.backgroundCardDark : AppColors.backgroundCardLight);

    final onSurfaceColor = highContrast
        ? (isDark ? AppColors.hcPrimaryTextDark : AppColors.hcPrimaryTextLight)
        : (isDark
            ? AppColors.primaryTextColorDark
            : AppColors.primaryTextColorLight);

    final primaryColor = highContrast
        ? (isDark ? AppColors.hcAccentDark : AppColors.hcAccentLight)
        : (isDark
            ? AppColors.secondTextColorDark
            : AppColors.secondTextColorLight);

    final onPrimaryColor = highContrast
        ? (isDark ? AppColors.hcOnAccentDark : AppColors.hcOnAccentLight)
        : (isDark
            ? AppColors.primaryTextColorDark
            : AppColors.backgroundCardLight);

    final borderColor = highContrast
        ? (isDark ? AppColors.hcBorderDark : AppColors.hcBorderLight)
        : (isDark ? AppColors.borderCardDark : AppColors.listScreenBorderLight);

    final colorScheme = isDark
        ? ColorScheme.dark(
            primary: primaryColor,
            onPrimary: onPrimaryColor,
            secondary: primaryColor,
            onSecondary: onSurfaceColor,
            tertiary: onSurfaceColor,
            onTertiary: onSurfaceColor,
            surface: surfaceColor,
            onSurface: onSurfaceColor,
            error: AppColors.borderError,
            onError: onSurfaceColor,
            errorContainer: AppColors.backgroundError,
            onErrorContainer: AppColors.borderError,
            outline: borderColor,
          )
        : ColorScheme.light(
            primary: primaryColor,
            onPrimary: onPrimaryColor,
            secondary: primaryColor,
            onSecondary: onSurfaceColor,
            surface: surfaceColor,
            onSurface: onSurfaceColor,
            error: AppColors.borderError,
            onError: onSurfaceColor,
            errorContainer: AppColors.backgroundError,
            onErrorContainer: AppColors.borderError,
            outline: borderColor,
          );

    final textTheme = highContrast
        ? (isDark
            ? AppTextTheme.highContrastDark
            : AppTextTheme.highContrastLight)
        : (isDark ? AppTextTheme.dark : AppTextTheme.light);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppFonts.montserrat,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: colorScheme,
      extensions: [
        AppContrastExtension(isHighContrast: highContrast),
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: onSurfaceColor,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: borderColor,
            width: highContrast ? 2 : 1,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
      ),
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        errorStyle: AppTextTheme.error,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: borderColor,
            width: highContrast ? 2 : 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: primaryColor,
            width: highContrast ? 2.5 : 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.borderError,
            width: highContrast ? 2.5 : 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.borderError,
            width: highContrast ? 2 : 1,
          ),
        ),
      ),
    );
  }
}
