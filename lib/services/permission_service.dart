import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PermissionService {
  /// 권한 요청 (카메라, 사진, 파일 저장소)
  static Future<Map<String, bool>> requestPermissions() async {
    final Map<String, bool> permissionsStatus = {
      "카메라": false,
      "사진": false,
      "저장소": false,
    };

    if (Platform.isIOS) {
      // iOS 권한 요청
      permissionsStatus["카메라"] = await _requestPermission(Permission.camera);
      permissionsStatus["사진"] = await _requestPermission(Permission.photos);
    } else if (Platform.isAndroid) {
      // Android 권한 요청
      permissionsStatus["카메라"] = await _requestPermission(Permission.camera);

      // Android 11(API 30) 이상: READ_MEDIA_IMAGES 요청
      if (await _isAndroid11OrAbove()) {
        permissionsStatus["사진"] = await _requestPermission(Permission.photos);
        permissionsStatus["저장소"] =
            await _requestPermission(Permission.manageExternalStorage);
      } else {
        // Android 10 이하: READ_EXTERNAL_STORAGE 요청
        permissionsStatus["사진"] =
            await _requestPermission(Permission.storage);
        permissionsStatus["저장소"] =
            await _requestPermission(Permission.storage);
      }
    }

    return permissionsStatus;
  }

  /// Android 11(API 30) 이상 확인
  static Future<bool> _isAndroid11OrAbove() async {
    if (!Platform.isAndroid) return false;
    // 실제 SDK 버전 확인을 위한 더 정확한 방법
    try {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 30;
    } catch (e) {
      // fallback: 기본값으로 30 이상으로 가정
      return true;
    }
  }

  /// 개별 권한 요청
  static Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.status;
    print('${permission.toString()} 권한 초기 상태: $status');

    if (status.isGranted) {
      // 이미 권한이 허용된 경우
      print("${permission.toString()} 권한이 이미 허용되었습니다.");
      return true;
    } else if (status.isPermanentlyDenied) {
      // 영구적으로 거부된 경우
      print("${permission.toString()} 권한이 영구적으로 거부되었습니다.");
      return false;
    } else {
      // 권한 요청
      print("${permission.toString()} 권한 요청 중...");
      final requestStatus = await permission.request();
      print("${permission.toString()} 권한 요청 결과: $requestStatus");
      return requestStatus.isGranted;
    }
  }

  /// 카메라 권한만 요청
  static Future<bool> requestCameraPermission() async {
    return await _requestPermission(Permission.camera);
  }

  /// 갤러리 권한만 요청
  static Future<bool> requestPhotosPermission() async {
    return await _requestPermission(Permission.photos);
  }

  /// 권한 상태 확인
  static Future<Map<String, PermissionStatus>> checkPermissionStatus() async {
    return {
      "카메라": await Permission.camera.status,
      "사진": await Permission.photos.status,
    };
  }
}
