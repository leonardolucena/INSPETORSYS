import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.color,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
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
    final trackWidth = 13.w;
    final trackHeight = 3.5.h;
    final thumbSize = 2.8.h;
    final thumbPadding = 0.4.w;

    final control = GestureDetector(
      onTap: isEnabled ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: trackWidth,
        height: trackHeight,
        decoration: BoxDecoration(
          color: value ? contentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(trackHeight / 2),
          border: Border.all(color: contentColor),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(thumbPadding),
            child: Container(
              width: thumbSize,
              height: thumbSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value ? colorScheme.onPrimary : contentColor,
              ),
            ),
          ),
        ),
      ),
    );

    if (label == null) {
      return control;
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
