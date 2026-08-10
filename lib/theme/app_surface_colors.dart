import 'package:flutter/material.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:inspetorsys/theme/app_contrast_extension.dart';

abstract final class AppSurfaceColors {
  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color _resolve(
    BuildContext context, {
    required Color normalLight,
    required Color normalDark,
    required Color highContrastLight,
    required Color highContrastDark,
  }) {
    final isDark = _isDark(context);
    if (context.isHighContrast) {
      return isDark ? highContrastDark : highContrastLight;
    }

    return isDark ? normalDark : normalLight;
  }

  static Color screenBackground(BuildContext context) => _resolve(
        context,
        normalLight: AppColors.listScreenBackgroundLight,
        normalDark: AppColors.backgroundCardDark,
        highContrastLight: AppColors.hcScreenBackgroundLight,
        highContrastDark: AppColors.hcScreenBackgroundDark,
      );

  static Color cardBackground(BuildContext context) => _resolve(
        context,
        normalLight: AppColors.backgroundCardLight,
        normalDark: AppColors.backgroundCardDark,
        highContrastLight: AppColors.hcCardBackgroundLight,
        highContrastDark: AppColors.hcCardBackgroundDark,
      );

  static Color elevatedSurface(BuildContext context) => _resolve(
        context,
        normalLight: AppColors.listScreenCardLight,
        normalDark: AppColors.backgroundDark,
        highContrastLight: AppColors.hcCardBackgroundLight,
        highContrastDark: AppColors.hcCardBackgroundDark,
      );

  static Color cardBorder(BuildContext context) => _resolve(
        context,
        normalLight: AppColors.listScreenBorderLight,
        normalDark: AppColors.borderCardDark,
        highContrastLight: AppColors.hcBorderLight,
        highContrastDark: AppColors.hcBorderDark,
      );

  static Color subtleBorder(BuildContext context) {
    if (context.isHighContrast) {
      return cardBorder(context);
    }

    final isDark = _isDark(context);
    return isDark
        ? AppColors.borderCardDark
        : AppColors.primaryTextColorLight.withValues(alpha: 0.15);
  }

  static Color inputBorder(BuildContext context) {
    if (context.isHighContrast) {
      return cardBorder(context);
    }

    final isDark = _isDark(context);
    return isDark
        ? AppColors.borderCardDark
        : AppColors.primaryTextColorLight.withValues(alpha: 0.3);
  }

  static Color shimmerBase(BuildContext context) => _resolve(
        context,
        normalLight: AppColors.segmentControlTrackLight,
        normalDark: AppColors.borderCardDark,
        highContrastLight: AppColors.hcBorderLight,
        highContrastDark: AppColors.hcBorderDark,
      );

  static Color segmentTrack(BuildContext context) => _resolve(
        context,
        normalLight: AppColors.segmentControlTrackLight,
        normalDark: AppColors.segmentControlTrackDark,
        highContrastLight: AppColors.hcCardBackgroundLight,
        highContrastDark: AppColors.hcCardBackgroundDark,
      );

  static Color segmentBorder(BuildContext context) => cardBorder(context);

  static Color segmentThumb(BuildContext context) => _resolve(
        context,
        normalLight: AppColors.segmentControlThumbLight,
        normalDark: AppColors.segmentControlThumbDark,
        highContrastLight: AppColors.hcAccentLight,
        highContrastDark: AppColors.hcAccentDark,
      );

  static Color segmentSelectedText(BuildContext context) => _resolve(
        context,
        normalLight: AppColors.thirdTextColorLight,
        normalDark: AppColors.thirdTextColorDark,
        highContrastLight: AppColors.hcOnAccentLight,
        highContrastDark: AppColors.hcOnAccentDark,
      );

  static Color segmentUnselectedText(BuildContext context) {
    if (context.isHighContrast) {
      return _isDark(context)
          ? AppColors.hcPrimaryTextDark
          : AppColors.hcPrimaryTextLight;
    }

    final isDark = _isDark(context);
    return isDark
        ? AppColors.thirdTextColorDark.withValues(alpha: 0.65)
        : AppColors.primaryTextColorLight.withValues(alpha: 0.75);
  }
}
