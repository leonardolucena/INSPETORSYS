import 'package:responsive_sizer/responsive_sizer.dart';

abstract final class AppSizes {
  static double get borderRadius => 2.1.w;
  static double get buttonPaddingH => 6.w;
  static double get buttonPaddingV => 1.4.h;
  static double get cardPadding => 4.w;
  static double get cardRadius => 3.w;
  static double get spacingXs => 0.5.h;
  static double get spacingSm => 1.h;
  static double get spacingMd => 2.h;
  static double get spacingLg => 3.h;
  static double get spacingXl => 4.h;
  static double get spacing2xl => 6.h;
  static double get spacing3xl => 12.h;
  static double get iconMd => 5.w;
  static double get iconSm => 4.w;
  static double get iconLg => 8.w;
  static const double drawerAppBarIconButtonWidth = 44;
  static double get drawerAppBarLeadingWidth =>
      drawerAppBarIconButtonWidth * 2;
  static double get drawerAppBarLeadingWidthCompact =>
      drawerAppBarIconButtonWidth;
  static double get inputSuffixIconSize => 6.5.w;
  static double get errorAreaHeight => 4.h;
  static double get errorAreaHeightCompact => 2.h;
  static double get inputPaddingH => 4.w;
  static double get inputPaddingV => 1.8.h;
  static double get badgePaddingH => 2.5.w;
  static double get badgePaddingV => 0.6.h;
  static double get stateMinHeight => 30.h;
  static double get shimmerHeight => 2.h;
  static double get shimmerRadius => 1.5.w;
  static double get mapHeight => 25.h;
  static double get mapMarkerSize => 9.w;
}
