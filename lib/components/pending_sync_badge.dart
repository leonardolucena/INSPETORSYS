import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class PendingSyncBadge extends StatelessWidget {
  const PendingSyncBadge({
    super.key,
    required this.count,
    required this.child,
  });

  final int count;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) {
      return child;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final label = count > 99 ? '99+' : '$count';

    return Badge(
      label: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isDark
                  ? AppColors.statusPendingBgDark
                  : AppColors.statusPendingBg,
              fontWeight: FontWeight.w700,
            ),
      ),
      backgroundColor:
          isDark ? AppColors.statusPendingDark : AppColors.statusPending,
      offset: Offset(AppSizes.spacingXs, -AppSizes.spacingXs),
      child: child,
    );
  }
}
