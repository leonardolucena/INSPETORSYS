import 'package:flutter/material.dart';
import 'package:inspetorsys/theme/app_colors.dart';

class AppAccentUnderlineText extends StatelessWidget {
  const AppAccentUnderlineText({
    super.key,
    required this.label,
    this.style,
    this.underlineColor,
    this.underlineHeight = 2.5,
    this.gap = 1,
  });

  final String label;
  final TextStyle? style;
  final Color? underlineColor;
  final double underlineHeight;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final resolvedStyle = (style ?? Theme.of(context).textTheme.titleMedium)
        ?.copyWith(
          fontWeight: FontWeight.bold,
          height: 1,
          color: isDark
              ? AppColors.thirdTextColorDark
              : const Color(0xFF424242),
          letterSpacing: 0.4,
        );
    final resolvedUnderlineColor = underlineColor ??
        (isDark
            ? AppColors.secondTextColorDark
            : AppColors.secondTextColorLight);

    return LayoutBuilder(
      builder: (context, constraints) {
        final displayText = label.toUpperCase();
        final textPainter = TextPainter(
          text: TextSpan(text: displayText, style: resolvedStyle),
          maxLines: 1,
          textDirection: Directionality.of(context),
        )..layout();

        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              displayText,
              maxLines: 1,
              softWrap: false,
              style: resolvedStyle,
              strutStyle: const StrutStyle(
                height: 1,
                forceStrutHeight: true,
              ),
            ),
            SizedBox(height: gap),
            Container(
              height: underlineHeight,
              width: textPainter.size.width,
              color: resolvedUnderlineColor,
            ),
          ],
        );

        return Align(
          alignment: Alignment.centerLeft,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth,
              ),
              child: content,
            ),
          ),
        );
      },
    );
  }
}
