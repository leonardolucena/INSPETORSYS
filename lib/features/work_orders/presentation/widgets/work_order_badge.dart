import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_priority.dart';
import 'package:inspetorsys/features/work_orders/domain/enums/work_order_status.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class WorkOrderStatusBadge extends StatelessWidget {
  const WorkOrderStatusBadge({
    super.key,
    required this.status,
  });

  final WorkOrderStatus status;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = _resolveAccent(isDark);

    return _WorkOrderBadge(
      label: status.label,
      accent: accent,
    );
  }

  Color _resolveAccent(bool isDark) {
    return switch (status) {
      WorkOrderStatus.open => isDark
          ? AppColors.workOrderStatusOpenAccentDark
          : AppColors.workOrderStatusOpenAccent,
      WorkOrderStatus.inProgress => isDark
          ? AppColors.workOrderStatusInProgressAccentDark
          : AppColors.workOrderStatusInProgressAccent,
      WorkOrderStatus.done => isDark
          ? AppColors.workOrderStatusDoneAccentDark
          : AppColors.workOrderStatusDoneAccent,
    };
  }
}

class WorkOrderPriorityBadge extends StatelessWidget {
  const WorkOrderPriorityBadge({
    super.key,
    required this.priority,
  });

  final WorkOrderPriority priority;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = _resolveAccent(isDark);

    return _WorkOrderBadge(
      label: priority.label,
      accent: accent,
    );
  }

  Color _resolveAccent(bool isDark) {
    return switch (priority) {
      WorkOrderPriority.high => isDark
          ? AppColors.workOrderPriorityHighAccentDark
          : AppColors.workOrderPriorityHighAccent,
      WorkOrderPriority.medium => isDark
          ? AppColors.workOrderPriorityMediumAccentDark
          : AppColors.workOrderPriorityMediumAccent,
      WorkOrderPriority.low => isDark
          ? AppColors.workOrderPriorityLowAccentDark
          : AppColors.workOrderPriorityLowAccent,
    };
  }
}

class _WorkOrderBadge extends StatelessWidget {
  const _WorkOrderBadge({
    required this.label,
    required this.accent,
  });

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundAlpha = isDark ? 0.18 : 0.10;
    final borderAlpha = isDark ? 0.42 : 0.28;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.badgePaddingH,
        vertical: AppSizes.badgePaddingV,
      ),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: backgroundAlpha),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        border: Border.all(
          color: accent.withValues(alpha: borderAlpha),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: accent,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
