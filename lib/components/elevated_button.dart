import 'package:flutter/material.dart';
import 'package:inspetorsys/components/button_content.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.darkTextColor,
    this.labelStyle,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? darkTextColor;
  final TextStyle? labelStyle;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackgroundColor = backgroundColor ?? colorScheme.primary;
    final effectiveBorderColor = borderColor ?? effectiveBackgroundColor;
    final effectiveTextColor = textColor ??
        (isDark ? darkTextColor ?? AppColors.fourthTextColorDark : null) ??
        colorScheme.onPrimary;
    final isEnabled = enabled && onPressed != null;

    final fillColor = isEnabled
        ? effectiveBackgroundColor
        : effectiveBackgroundColor.withValues(alpha: 0.5);
    final strokeColor =
        isEnabled ? effectiveBorderColor : effectiveBorderColor.withValues(alpha: 0.5);
    final contentColor =
        isEnabled ? effectiveTextColor : effectiveTextColor.withValues(alpha: 0.5);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        child: Ink(
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            border: Border.all(color: strokeColor),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.buttonPaddingH,
              vertical: AppSizes.buttonPaddingV,
            ),
            child: AppButtonContent(
              label: label,
              icon: icon,
              color: contentColor,
              labelStyle: labelStyle,
            ),
          ),
        ),
      ),
    );
  }
}
