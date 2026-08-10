import 'package:flutter_test/flutter_test.dart';
import 'package:inspetorsys/core/constants/api_constants.dart';
import 'package:inspetorsys/core/image/inspection_photo_resolver.dart';

void main() {
  group('resolveInspectionPhotoSource', () {
    test('returns network source for absolute http urls', () {
      const url = 'https://cdn.example.com/photo.jpg';

      final source = resolveInspectionPhotoSource(url);

      expect(source?.type, InspectionPhotoSourceType.network);
      expect(source?.networkUrl, url);
    });

    test('returns network source for api relative upload paths', () {
      const path = '/uploads/photo.jpg';

      final source = resolveInspectionPhotoSource(path);

      expect(source?.type, InspectionPhotoSourceType.network);
      expect(source?.networkUrl, '${ApiConstants.baseUrl}$path');
    });

    test('returns file source for android absolute local paths', () {
      const path =
          '/data/user/0/com.example.inspetorsys/app_flutter/photos/123.jpg';

      final source = resolveInspectionPhotoSource(path);

      expect(source?.type, InspectionPhotoSourceType.file);
      expect(source?.path, path);
    });

    test('returns file source for relative local paths', () {
      const path = 'photos/123.jpg';

      final source = resolveInspectionPhotoSource(path);

      expect(source?.type, InspectionPhotoSourceType.file);
      expect(source?.path, path);
    });

    test('returns null for empty values', () {
      expect(resolveInspectionPhotoSource(null), isNull);
      expect(resolveInspectionPhotoSource(''), isNull);
    });
  });
}
