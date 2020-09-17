import 'package:permission_handler/permission_handler.dart';

class HandlePermission {
  Future<bool> reqPermission() async {
    bool status = false;
    status = await Permission.storage.status.isGranted;
    if (!status) {
      PermissionStatus permission = await Permission.storage.request();
      if (permission.isGranted) {
        // status = true;
        // print('permission ${permissionStatus.isGranted}');
        permissionStatus();
        // print('permission ${permissionStatus()}');
        status = true;
      }
      if (!permission.isGranted) {
        status = false;
      }
    }
    return status;
  }

  Future<bool> permissionStatus() async {
    bool status;
    if (await Permission.storage.status.isGranted) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }
}
