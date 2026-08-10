import 'package:flutter/material.dart';
import 'package:inspetorsys/constants/app_assets.dart';
import 'package:inspetorsys/theme/app_colors.dart';

abstract final class AppTextTheme {
  static TextTheme get light {
    return TextTheme(
      displayLarge: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 1.16,
      ),
      displaySmall: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 1.22,
      ),
      headlineLarge: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      headlineMedium: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.29,
      ),
      headlineSmall: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.33,
      ),
      titleLarge: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.27,
      ),
      titleMedium: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      titleSmall: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      bodyLarge: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.5,
      ),
      bodyMedium: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      bodySmall: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0.4,
      ),
      labelLarge: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: _style(
        color: AppColors.primaryTextColorLight,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    );
  }

  static TextTheme get dark {
    return TextTheme(
      displayLarge: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 1.16,
      ),
      displaySmall: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 1.22,
      ),
      headlineLarge: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      headlineMedium: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.29,
      ),
      headlineSmall: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.33,
      ),
      titleLarge: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.27,
      ),
      titleMedium: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      titleSmall: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      bodyLarge: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.5,
      ),
      bodyMedium: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      bodySmall: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0.4,
      ),
      labelLarge: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: _style(
        color: AppColors.primaryTextColorDark,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    );
  }

  static TextTheme get highContrastLight =>
      _emphasize(light).apply(bodyColor: AppColors.hcPrimaryTextLight, displayColor: AppColors.hcPrimaryTextLight);

  static TextTheme get highContrastDark =>
      _emphasize(dark).apply(bodyColor: AppColors.hcPrimaryTextDark, displayColor: AppColors.hcPrimaryTextDark);

  static TextTheme _emphasize(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontWeight: FontWeight.w700),
      displayMedium: base.displayMedium?.copyWith(fontWeight: FontWeight.w700),
      displaySmall: base.displaySmall?.copyWith(fontWeight: FontWeight.w700),
      headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
      headlineMedium:
          base.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
      titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w800),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w800),
      titleSmall: base.titleSmall?.copyWith(fontWeight: FontWeight.w800),
      bodyLarge: base.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      bodyMedium: base.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      bodySmall: base.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w800),
      labelMedium: base.labelMedium?.copyWith(fontWeight: FontWeight.w800),
      labelSmall: base.labelSmall?.copyWith(fontWeight: FontWeight.w800),
    );
  }

  static TextStyle get secondaryLight => _style(
        color: AppColors.secondTextColorLight,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
      );

  static TextStyle get secondaryDark => _style(
        color: AppColors.secondTextColorDark,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
      );

  static TextStyle get thirdDark => _style(
        color: AppColors.thirdTextColorDark,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
      );

  static TextStyle get error => _style(
        color: AppColors.borderError,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
      );

  static TextStyle _style({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: AppFonts.montserrat,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
