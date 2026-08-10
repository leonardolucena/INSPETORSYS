import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum AppSnackbarType {
  info,
  success,
  error,
}

abstract final class AppSnackbar {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void show(
    BuildContext context, {
    required String message,
    AppSnackbarType type = AppSnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger =
        messengerKey.currentState ?? ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      return;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = _resolveColors(type, isDark);
    final icon = _resolveIcon(type);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: colors.foreground, size: 4.5.w),
              SizedBox(width: AppSizes.spacingSm),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.foreground,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          backgroundColor: colors.background,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: EdgeInsets.all(AppSizes.cardPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            side: BorderSide(color: colors.border),
          ),
          duration: duration,
        ),
      );
  }

  static void info(BuildContext context, String message) {
    show(context, message: message, type: AppSnackbarType.info);
  }

  static void success(BuildContext context, String message) {
    show(context, message: message, type: AppSnackbarType.success);
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, type: AppSnackbarType.error);
  }

  static IconData _resolveIcon(AppSnackbarType type) {
    return switch (type) {
      AppSnackbarType.info => Icons.info_outline,
      AppSnackbarType.success => Icons.check_circle_outline,
      AppSnackbarType.error => Icons.error_outline,
    };
  }

  static _SnackbarColors _resolveColors(AppSnackbarType type, bool isDark) {
    return switch (type) {
      AppSnackbarType.info => const _SnackbarColors(
          background: AppColors.backgroundCardLight,
          border: AppColors.listScreenBorderLight,
          foreground: AppColors.primaryTextColorLight,
        ),
      AppSnackbarType.success => _SnackbarColors(
          background: isDark
              ? AppColors.statusSuccessBgDark
              : AppColors.statusSuccessBg,
          border: isDark
              ? AppColors.statusSuccessBorderDark
              : AppColors.statusSuccessBorder,
          foreground:
              isDark ? AppColors.statusSuccessDark : AppColors.statusSuccess,
        ),
      AppSnackbarType.error => _SnackbarColors(
          background:
              isDark ? AppColors.statusDangerBgDark : AppColors.statusDangerBg,
          border: isDark
              ? AppColors.statusDangerBorderDark
              : AppColors.statusDangerBorder,
          foreground:
              isDark ? AppColors.statusDangerDark : AppColors.statusDanger,
        ),
    };
  }
}

class _SnackbarColors {
  const _SnackbarColors({
    required this.background,
    required this.border,
    required this.foreground,
  });

  final Color background;
  final Color border;
  final Color foreground;
}
