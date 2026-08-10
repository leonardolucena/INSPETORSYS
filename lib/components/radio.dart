import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.color,
    this.enabled = true,
    this.dense = false,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final Color? color;
  final bool enabled;
  final bool dense;

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;
    final isEnabled = enabled && onChanged != null;
    final contentColor =
        isEnabled ? effectiveColor : effectiveColor.withValues(alpha: 0.5);
    final size = 6.w;
    final innerSize = 3.w;

    final control = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: contentColor, width: 2),
      ),
      child: _isSelected
          ? Center(
              child: Container(
                width: innerSize,
                height: innerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: contentColor,
                ),
              ),
            )
          : null,
    );

    if (label == null) {
      return GestureDetector(
        onTap: isEnabled ? () => onChanged!(value) : null,
        child: control,
      );
    }

    return GestureDetector(
      onTap: isEnabled ? () => onChanged!(value) : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: dense ? 0 : AppSizes.buttonPaddingV,
        ),
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
