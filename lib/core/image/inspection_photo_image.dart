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

    return switch (source.type) {
      InspectionPhotoSourceType.file => Image.file(
          File(source.path!),
          height: height,
          width: width,
          fit: fit,
        ),
      InspectionPhotoSourceType.network => Image.network(
          source.networkUrl!,
          height: height,
          width: width,
          fit: fit,
        ),
    };
  }
}
