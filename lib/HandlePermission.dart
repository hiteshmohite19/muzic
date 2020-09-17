import 'package:permission_handler/permission_handler.dart';

class HandlePermission {
  Future<bool> reqPermission() async {
    bool status = false;
    status = await Permission.storage.status.isGranted;
    if (!status) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        status = true;
      }
      if (!permissionStatus.isGranted) {
        status = false;
      }
    }
    return status;
  }

  Future<bool> permissionStatus() async {
    if (await Permission.storage.status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
