import 'dart:io';

import 'package:inspetorsys/core/constants/api_constants.dart';

enum InspectionPhotoSourceType {
  file,
  network,
}

class InspectionPhotoSource {
  const InspectionPhotoSource.file(this.path)
      : type = InspectionPhotoSourceType.file,
        networkUrl = null;

  const InspectionPhotoSource.network(this.networkUrl)
      : type = InspectionPhotoSourceType.network,
        path = null;

  final InspectionPhotoSourceType type;
  final String? path;
  final String? networkUrl;
}

/// Resolves a stored inspection photo reference to a local file or network URL.
///
/// Local paths are preferred. Relative API paths such as `/uploads/...` are
/// prefixed with [ApiConstants.baseUrl].
InspectionPhotoSource? resolveInspectionPhotoSource(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  if (value.startsWith('http://') || value.startsWith('https://')) {
    return InspectionPhotoSource.network(value);
  }

  if (value.startsWith('/')) {
    return InspectionPhotoSource.network('${ApiConstants.baseUrl}$value');
  }

  final file = File(value);
  if (file.existsSync()) {
    return InspectionPhotoSource.file(value);
  }

  return null;
}

String? resolveInspectionPhotoPathForPersistence({
  required String? localPhotoPath,
  String? remotePhotoUrl,
}) {
  if (localPhotoPath != null &&
      localPhotoPath.isNotEmpty &&
      File(localPhotoPath).existsSync()) {
    return localPhotoPath;
  }

  return remotePhotoUrl ?? localPhotoPath;
}
