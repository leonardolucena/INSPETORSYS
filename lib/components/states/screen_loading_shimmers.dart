import 'package:flutter/material.dart';
import 'package:inspetorsys/core/responsive/app_sizes.dart';
import 'package:inspetorsys/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class WorkOrderDetailShimmer extends StatelessWidget {
  const WorkOrderDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _ListScreenShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ShimmerSectionCard(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _ShimmerBone(
                      width: 36.w,
                      height: AppSizes.shimmerHeight * 2.4,
                    ),
                  ),
                  SizedBox(width: AppSizes.spacingSm),
                  _ShimmerBone(
                    width: 14.w,
                    height: AppSizes.shimmerHeight * 2.6,
                    borderRadius: AppSizes.borderRadius,
                  ),
                  SizedBox(width: AppSizes.spacingXs),
                  _ShimmerBone(
                    width: 18.w,
                    height: AppSizes.shimmerHeight * 2.6,
                    borderRadius: AppSizes.borderRadius,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.spacingSm),
              _ShimmerBone(
                width: double.infinity,
                height: AppSizes.shimmerHeight * 2.2,
              ),
              SizedBox(height: AppSizes.spacingXs),
              _ShimmerBone(
                width: 80.w,
                height: AppSizes.shimmerHeight * 1.8,
              ),
              SizedBox(height: AppSizes.spacingMd),
              _ShimmerBone(
                width: double.infinity,
                height: AppSizes.shimmerHeight * 1.8,
              ),
              SizedBox(height: AppSizes.spacingSm),
              _ShimmerBone(
                width: double.infinity,
                height: AppSizes.shimmerHeight * 1.8,
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacingMd),
          _ShimmerSectionCard(
            children: [
              _ShimmerBone(
                width: 28.w,
                height: AppSizes.shimmerHeight * 2.2,
              ),
              SizedBox(height: AppSizes.spacingSm),
              _ShimmerBone(
                width: double.infinity,
                height: AppSizes.mapHeight,
                borderRadius: AppSizes.cardRadius,
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacingLg),
          _ShimmerBone(
            width: double.infinity,
            height: AppSizes.buttonPaddingV * 2 + AppSizes.shimmerHeight * 2,
            borderRadius: AppSizes.borderRadius,
          ),
        ],
      ),
    );
  }
}

class InspectionFormShimmer extends StatelessWidget {
  const InspectionFormShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _ListScreenShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FormSectionShimmer(
            cardHeight: AppSizes.shimmerHeight * 14,
          ),
          SizedBox(height: AppSizes.spacingLg),
          _FormSectionShimmer(
            cardHeight: AppSizes.buttonPaddingV * 2 + AppSizes.shimmerHeight * 2,
          ),
          SizedBox(height: AppSizes.spacingLg),
          _FormSectionShimmer(
            cardHeight: AppSizes.buttonPaddingV * 2 + AppSizes.shimmerHeight * 8,
          ),
          SizedBox(height: AppSizes.spacingLg),
          _FormSectionShimmer(
            cardHeight: AppSizes.shimmerHeight * 10,
          ),
          SizedBox(height: AppSizes.spacingXl),
          _ShimmerBone(
            width: double.infinity,
            height: AppSizes.buttonPaddingV * 2 + AppSizes.shimmerHeight * 2,
            borderRadius: AppSizes.borderRadius,
          ),
          SizedBox(height: AppSizes.spacingSm),
          _ShimmerBone(
            width: double.infinity,
            height: AppSizes.buttonPaddingV * 2 + AppSizes.shimmerHeight * 2,
            borderRadius: AppSizes.borderRadius,
          ),
        ],
      ),
    );
  }
}

class _FormSectionShimmer extends StatelessWidget {
  const _FormSectionShimmer({
    required this.cardHeight,
  });

  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ShimmerBone(
          width: 40.w,
          height: AppSizes.shimmerHeight * 2.2,
        ),
        SizedBox(height: AppSizes.spacingSm),
        _ShimmerSectionCard(
          children: [
            _ShimmerBone(
              width: double.infinity,
              height: cardHeight,
              borderRadius: AppSizes.borderRadius,
            ),
          ],
        ),
      ],
    );
  }
}

class _ListScreenShimmer extends StatelessWidget {
  const _ListScreenShimmer({required this.child});

  final Widget child;

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
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}

class _ShimmerSectionCard extends StatelessWidget {
  const _ShimmerSectionCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor =
        isDark ? AppColors.backgroundDark : AppColors.listScreenCardLight;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _ShimmerBone extends StatelessWidget {
  const _ShimmerBone({
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final double width;
  final double height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final boneColor = isDark
        ? AppColors.borderCardDark
        : AppColors.segmentControlTrackLight;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: boneColor,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppSizes.shimmerRadius,
        ),
      ),
    );
  }
}
