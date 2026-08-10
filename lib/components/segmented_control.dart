import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_surface_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppSegmentedControlSegment<T> {
  const AppSegmentedControlSegment({
    required this.value,
    required this.label,
    this.flex = 1,
  });

  final T value;
  final String label;
  final int flex;
}

class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onSelected,
  });

  final List<AppSegmentedControlSegment<T>> segments;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = segments.indexWhere(
      (segment) => segment.value == selected,
    );
    final safeIndex = selectedIndex < 0 ? 0 : selectedIndex;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor = AppSurfaceColors.segmentTrack(context);
    final trackBorderColor = AppSurfaceColors.segmentBorder(context);
    final thumbColor = AppSurfaceColors.segmentThumb(context);
    final selectedTextColor = AppSurfaceColors.segmentSelectedText(context);
    final unselectedTextColor = AppSurfaceColors.segmentUnselectedText(context);

    return Container(
      height: 5.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: trackBorderColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidths = _segmentWidths(constraints.maxWidth);
          const thumbInset = 3.0;
          var thumbLeft = 0.0;
          for (var index = 0; index < safeIndex; index++) {
            thumbLeft += segmentWidths[index];
          }
          final thumbWidth = (segmentWidths[safeIndex] - (thumbInset * 2))
              .clamp(0.0, double.infinity);

          return Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.hardEdge,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOutCubic,
                left: thumbLeft + thumbInset,
                top: thumbInset,
                bottom: thumbInset,
                width: thumbWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: thumbColor,
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                    boxShadow: isDark
                        ? null
                        : const [
                            BoxShadow(
                              color: Color(0x141D2847),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                  ),
                ),
              ),
              Row(
                children: [
                  for (var index = 0; index < segments.length; index++)
                    Expanded(
                      flex: segments[index].flex,
                      child: _SegmentButton(
                        label: segments[index].label,
                        isSelected: index == safeIndex,
                        selectedTextColor: selectedTextColor,
                        unselectedTextColor: unselectedTextColor,
                        onTap: () => onSelected(segments[index].value),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  List<double> _segmentWidths(double maxWidth) {
    final totalFlex =
        segments.fold<int>(0, (sum, segment) => sum + segment.flex);
    final widths = <double>[];
    var usedWidth = 0.0;

    for (var index = 0; index < segments.length; index++) {
      if (index == segments.length - 1) {
        widths.add(maxWidth - usedWidth);
      } else {
        final width = maxWidth * segments[index].flex / totalFlex;
        widths.add(width);
        usedWidth += width;
      }
    }

    return widths;
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color:
                          isSelected ? selectedTextColor : unselectedTextColor,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
