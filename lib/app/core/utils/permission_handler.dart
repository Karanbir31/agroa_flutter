import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  /// Request permissions required for the app (Camera, Microphone, etc.)
  static Future<bool> requestAppPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.phone,
      Permission.bluetoothConnect,
    ].request();

    // Check if all requested permissions are granted
    bool allGranted = statuses.values.every((status) => status.isGranted);
    
    return allGranted;
  }

  /// Check the status of a specific permission
  static Future<PermissionStatus> getPermissionStatus(Permission permission) async {
    return await permission.status;
  }

  /// Specifically check if Camera and Microphone are granted (common for Agora)
  static Future<bool> hasAgoraPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus microphoneStatus = await Permission.microphone.status;
    
    return cameraStatus.isGranted && microphoneStatus.isGranted;
  }
}
