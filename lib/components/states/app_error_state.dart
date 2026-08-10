import 'package:flutter/material.dart';
import 'package:inspetorsys/components/elevated_button.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    this.title = 'Algo deu errado',
    this.retryLabel = 'Tentar novamente',
    this.onRetry,
    this.minHeight,
  });

  final String title;
  final String message;
  final String retryLabel;
  final VoidCallback? onRetry;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
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
            Icons.error_outline,
            size: AppSizes.iconLg,
            color: AppColors.borderError,
          ),
          SizedBox(height: AppSizes.spacingMd),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppSizes.spacingSm),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.borderError,
                ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: AppSizes.spacingMd),
            AppElevatedButton(
              label: retryLabel,
              onPressed: onRetry,
            ),
          ],
        ],
      ),
      ),
    );
  }
}
