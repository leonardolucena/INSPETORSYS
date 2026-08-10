import 'package:flutter/material.dart';
import 'package:inspetorsys/components/button_content.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';

class AppInlineButton extends StatelessWidget {
  const AppInlineButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;
    final isEnabled = enabled && onPressed != null;
    final contentColor =
        isEnabled ? effectiveColor : effectiveColor.withValues(alpha: 0.5);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            border: Border.all(color: Colors.transparent),
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
            ),
          ),
        ),
      ),
    );
  }
}
