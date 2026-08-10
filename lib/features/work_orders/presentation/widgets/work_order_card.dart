import 'package:flutter/material.dart';
import 'package:inspetorsys/components/accent_underline_text.dart';
import 'package:inspetorsys/components/card.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/features/work_orders/domain/entities/work_order.dart';
import 'package:inspetorsys/features/work_orders/presentation/widgets/work_order_badge.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class WorkOrderCard extends StatelessWidget {
  const WorkOrderCard({
    super.key,
    required this.workOrder,
    this.onTap,
    this.invertedSurface = false,
  });

  final WorkOrder workOrder;
  final VoidCallback? onTap;
  final bool invertedSurface;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = invertedSurface
        ? (isDark
            ? AppColors.backgroundDark
            : AppColors.listScreenCardLight)
        : null;
    final borderColor = invertedSurface
        ? (isDark
            ? AppColors.borderCardDark
            : AppColors.listScreenBorderLight)
        : null;

    return AppCard(
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      showBorder: !invertedSurface,
      margin: EdgeInsets.only(bottom: AppSizes.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AppAccentUnderlineText(label: workOrder.code),
              ),
              SizedBox(width: AppSizes.spacingSm),
              Wrap(
                spacing: AppSizes.spacingXs,
                runSpacing: AppSizes.spacingXs,
                alignment: WrapAlignment.end,
                children: [
                  WorkOrderPriorityBadge(priority: workOrder.priority),
                  WorkOrderStatusBadge(status: workOrder.status),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacingXs),
          Text(
            workOrder.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppSizes.spacingXs),
          Text(
            workOrder.address,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
