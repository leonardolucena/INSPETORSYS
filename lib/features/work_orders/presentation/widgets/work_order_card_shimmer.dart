import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class WorkOrderListShimmer extends StatelessWidget {
  const WorkOrderListShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark
        ? AppColors.borderCardDark
        : AppColors.segmentControlTrackLight;
    final highlightColor = isDark
        ? AppColors.backgroundCardDark
        : AppColors.listScreenCardLight;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        children: List.generate(
          itemCount,
          (_) => const WorkOrderCardShimmer(),
        ),
      ),
    );
  }
}

class WorkOrderCardShimmer extends StatelessWidget {
  const WorkOrderCardShimmer({
    super.key,
    this.invertedSurface = true,
  });

  final bool invertedSurface;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = invertedSurface
        ? (isDark
            ? AppColors.backgroundDark
            : AppColors.listScreenCardLight)
        : (isDark
            ? AppColors.backgroundCardDark
            : AppColors.backgroundCardLight);
    final boneColor = isDark
        ? AppColors.borderCardDark
        : AppColors.segmentControlTrackLight;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSizes.spacingMd),
      padding: EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _ShimmerBone(
                  color: boneColor,
                  width: 32.w,
                  height: AppSizes.shimmerHeight * 2.2,
                ),
              ),
              SizedBox(width: AppSizes.spacingSm),
              _ShimmerBone(
                color: boneColor,
                width: 14.w,
                height: AppSizes.shimmerHeight * 2.6,
                borderRadius: AppSizes.borderRadius,
              ),
              SizedBox(width: AppSizes.spacingXs),
              _ShimmerBone(
                color: boneColor,
                width: 18.w,
                height: AppSizes.shimmerHeight * 2.6,
                borderRadius: AppSizes.borderRadius,
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacingSm),
          _ShimmerBone(
            color: boneColor,
            width: double.infinity,
            height: AppSizes.shimmerHeight * 2.2,
          ),
          SizedBox(height: AppSizes.spacingXs),
          _ShimmerBone(
            color: boneColor,
            width: 72.w,
            height: AppSizes.shimmerHeight * 1.8,
          ),
        ],
      ),
    );
  }
}

class _ShimmerBone extends StatelessWidget {
  const _ShimmerBone({
    required this.color,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final Color color;
  final double width;
  final double height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppSizes.shimmerRadius,
        ),
      ),
    );
  }
}
