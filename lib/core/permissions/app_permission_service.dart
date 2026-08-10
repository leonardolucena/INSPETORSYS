import 'package:inspetorsys/core/permissions/app_permission.dart';
import 'package:inspetorsys/core/permissions/permission_service.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@LazySingleton(as: PermissionService)
class AppPermissionService implements PermissionService {
  @override
  Future<bool> isGranted(AppPermission permission) async {
    final status = await _mapPermission(permission).status;
    return status.isGranted;
  }

  @override
  Future<bool> request(AppPermission permission) async {
    final status = await _mapPermission(permission).request();
    return status.isGranted;
  }

  @override
  Future<bool> ensureGranted(AppPermission permission) async {
    if (await isGranted(permission)) {
      return true;
    }

    return request(permission);
  }

  @override
  Future<void> openSettings() {
    return openAppSettings();
  }

  Permission _mapPermission(AppPermission permission) {
    return switch (permission) {
      AppPermission.camera => Permission.camera,
      AppPermission.location => Permission.locationWhenInUse,
    };
  }
}
