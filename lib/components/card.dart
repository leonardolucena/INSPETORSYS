import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_surface_colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.showBorder = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final resolvedBackgroundColor =
        backgroundColor ?? AppSurfaceColors.cardBackground(context);
    final resolvedBorderColor =
        borderColor ?? AppSurfaceColors.subtleBorder(context);

    final card = Container(
      width: double.infinity,
      margin: margin,
      padding: padding ?? EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: resolvedBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: showBorder ? Border.all(color: resolvedBorderColor) : null,
      ),
      child: child,
    );

    if (onTap == null) {
      return card;
    }

    return GestureDetector(
      onTap: onTap,
      child: card,
    );
  }
}
