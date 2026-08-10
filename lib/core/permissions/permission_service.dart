import 'package:inspetorsys/core/permissions/app_permission.dart';

abstract interface class PermissionService {
  Future<bool> isGranted(AppPermission permission);

  Future<bool> request(AppPermission permission);

  Future<bool> ensureGranted(AppPermission permission);

  Future<void> openSettings();
}
