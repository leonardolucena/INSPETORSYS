import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';

class AppButtonContent extends StatelessWidget {
  const AppButtonContent({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.labelStyle,
    this.expand = true,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final TextStyle? labelStyle;

  /// When true, stretches to the parent's width (forms). When false, sizes to
  /// content (e.g. chips inside a horizontal [Row]).
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final textStyle = (labelStyle ?? Theme.of(context).textTheme.labelLarge)
        ?.copyWith(color: color);

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: AppSizes.iconMd,
            color: color,
          ),
          SizedBox(width: AppSizes.spacingXs),
        ],
        if (expand)
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          )
        else
          Text(
            label,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
      ],
    );

    if (!expand) {
      return content;
    }

    return SizedBox(width: double.infinity, child: content);
  }
}
