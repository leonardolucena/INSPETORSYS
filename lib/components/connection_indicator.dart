import 'package:flutter/material.dart';
import 'package:inspetorsys/core/connectivity/network_status.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class AppConnectionIndicator extends StatelessWidget {
  const AppConnectionIndicator({
    super.key,
    required this.status,
  });

  final NetworkStatus status;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = _resolveColors(status, isDark);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacingSm,
        vertical: AppSizes.spacingXs,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            colors.icon,
            size: AppSizes.iconSm,
            color: colors.foreground,
          ),
          SizedBox(width: AppSizes.spacingXs),
          Text(
            colors.label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.foreground,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  _ConnectionIndicatorColors _resolveColors(
    NetworkStatus status,
    bool isDark,
  ) {
    return switch (status) {
      NetworkStatus.online => _ConnectionIndicatorColors(
          label: 'Online',
          icon: Icons.wifi,
          foreground: isDark ? AppColors.statusSuccessDark : AppColors.statusSuccess,
          background:
              isDark ? AppColors.statusSuccessBgDark : AppColors.statusSuccessBg,
          border: isDark
              ? AppColors.statusSuccessBorderDark
              : AppColors.statusSuccessBorder,
        ),
      NetworkStatus.connectedNoInternet => _ConnectionIndicatorColors(
          label: 'Sem internet',
          icon: Icons.wifi_off,
          foreground:
              isDark ? AppColors.statusPendingDark : AppColors.statusPending,
          background:
              isDark ? AppColors.statusPendingBgDark : AppColors.statusPendingBg,
          border: isDark
              ? AppColors.statusPendingBorderDark
              : AppColors.statusPendingBorder,
        ),
      NetworkStatus.offline => _ConnectionIndicatorColors(
          label: 'Offline',
          icon: Icons.signal_wifi_off,
          foreground: isDark ? AppColors.statusDangerDark : AppColors.statusDanger,
          background:
              isDark ? AppColors.statusDangerBgDark : AppColors.statusDangerBg,
          border:
              isDark ? AppColors.statusDangerBorderDark : AppColors.statusDangerBorder,
        ),
    };
  }
}

class _ConnectionIndicatorColors {
  const _ConnectionIndicatorColors({
    required this.label,
    required this.icon,
    required this.foreground,
    required this.background,
    required this.border,
  });

  final String label;
  final IconData icon;
  final Color foreground;
  final Color background;
  final Color border;
}
