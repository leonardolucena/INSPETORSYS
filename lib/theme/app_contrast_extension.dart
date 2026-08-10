import 'package:flutter/material.dart';

@immutable
class AppContrastExtension extends ThemeExtension<AppContrastExtension> {
  const AppContrastExtension({required this.isHighContrast});

  final bool isHighContrast;

  @override
  AppContrastExtension copyWith({bool? isHighContrast}) {
    return AppContrastExtension(
      isHighContrast: isHighContrast ?? this.isHighContrast,
    );
  }

  @override
  AppContrastExtension lerp(AppContrastExtension? other, double t) {
    if (other == null) {
      return this;
    }

    return AppContrastExtension(
      isHighContrast: t < 0.5 ? isHighContrast : other.isHighContrast,
    );
  }
}

extension AppContrastContext on BuildContext {
  bool get isHighContrast =>
      Theme.of(this).extension<AppContrastExtension>()?.isHighContrast ?? false;
}
