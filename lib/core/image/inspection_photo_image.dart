import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inspetorsys/core/image/inspection_photo_resolver.dart';

class InspectionPhotoImage extends StatelessWidget {
  const InspectionPhotoImage({
    super.key,
    required this.photoReference,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  final String? photoReference;
  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final source = resolveInspectionPhotoSource(photoReference);
    if (source == null) {
      return const SizedBox.shrink();
    }

    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    final cacheHeight =
        height != null ? (height! * devicePixelRatio).round() : null;
    final cacheWidth = width != null && width!.isFinite
        ? (width! * devicePixelRatio).round()
        : null;

    return switch (source.type) {
      InspectionPhotoSourceType.file => Image.file(
          File(source.path!),
          height: height,
          width: width,
          fit: fit,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
          filterQuality: FilterQuality.medium,
          gaplessPlayback: true,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      InspectionPhotoSourceType.network => Image.network(
          source.networkUrl!,
          height: height,
          width: width,
          fit: fit,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
          filterQuality: FilterQuality.medium,
          gaplessPlayback: true,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
    };
  }
}
