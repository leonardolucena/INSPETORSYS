import 'package:flutter/material.dart';
import 'package:inspetorsys/components/elevated_button.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    this.minHeight,
  });

  final String title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight ?? AppSizes.stateMinHeight,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: AppSizes.iconLg,
            color: colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          SizedBox(height: AppSizes.spacingMd),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (message != null) ...[
            SizedBox(height: AppSizes.spacingSm),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
            ),
          ],
          if (actionLabel != null && onAction != null) ...[
            SizedBox(height: AppSizes.spacingMd),
            AppElevatedButton(
              label: actionLabel!,
              onPressed: onAction,
            ),
          ],
        ],
      ),
      ),
    );
  }
}
