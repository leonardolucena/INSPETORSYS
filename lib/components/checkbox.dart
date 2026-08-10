import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.color,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final Color? color;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = color ?? colorScheme.primary;
    final isEnabled = enabled && onChanged != null;
    final contentColor =
        isEnabled ? effectiveColor : effectiveColor.withValues(alpha: 0.5);
    final size = 6.w;

    final control = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: value ? contentColor : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        border: Border.all(color: contentColor),
      ),
      child: value
          ? Icon(
              Icons.check,
              size: 4.w,
              color: colorScheme.onPrimary,
            )
          : null,
    );

    if (label == null) {
      return GestureDetector(
        onTap: isEnabled ? () => onChanged!(!value) : null,
        child: control,
      );
    }

    return GestureDetector(
      onTap: isEnabled ? () => onChanged!(!value) : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.buttonPaddingV),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            control,
            SizedBox(width: AppSizes.spacingSm),
            Text(
              label!,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
