import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Checks storage permission across iOS and all Android versions
///
/// For Android 10+ (API level 29+), handles the scoped storage model
/// For iOS, handles Photos permission appropriately
///
/// Returns [true] if permission is granted, [false] otherwise
Future<bool> checkStoragePermission() async {
  if (Platform.isAndroid) {
    return await _checkAndroidStoragePermission();
  } else if (Platform.isIOS) {
    return await _checkIOSStoragePermission();
  }

  // Default fallback for other platforms
  return false;
}

/// Handles Android storage permission with version-specific logic
Future<bool> _checkAndroidStoragePermission() async {
  // Check Android SDK version
  final sdkInt = await _getAndroidSDKVersion();

  if (sdkInt >= 33) {
    // Android 13+ (API 33+) - Use granular media permissions
    final photos = await Permission.photos.status;
    final videos = await Permission.videos.status;

    if (photos.isDenied || videos.isDenied) {
      // Request permissions
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
        Permission.videos,
      ].request();

      return statuses[Permission.photos]!.isGranted &&
          statuses[Permission.videos]!.isGranted;
    }

    return photos.isGranted && videos.isGranted;
  } else if (sdkInt >= 29) {
    // Android 10-12 (API 29-32) - Uses scoped storage
    // Check for MANAGE_EXTERNAL_STORAGE for full access or
    // use the simpler storage permission for limited access
    if (await Permission.manageExternalStorage.isRestricted) {
      // Fall back to regular storage permission
      final status = await Permission.storage.request();
      return status.isGranted;
    } else {
      // Try to request manage external storage permission
      final status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    }
  } else {
    // Android 9 and below (API 28-) - Traditional storage permissions
    final status = await Permission.storage.request();
    return status.isGranted;
  }
}

/// Handles iOS storage permission logic
Future<bool> _checkIOSStoragePermission() async {
  // For iOS, we need to request photo library permission
  PermissionStatus photoStatus = await Permission.photos.status;

  if (photoStatus.isDenied ||
      photoStatus.isRestricted ||
      photoStatus.isPermanentlyDenied) {
    photoStatus = await Permission.photos.request();
  }

  // For file access, iOS uses different mechanisms not tied to permissions
  // But Photos permission is needed for media access
  return photoStatus.isGranted;
}

/// Helper method to get Android SDK version
Future<int> _getAndroidSDKVersion() async {
  if (!Platform.isAndroid) return 0;

  try {
    // This is a placeholder - in a real app, you'd use a method channel
    // or a plugin like device_info_plus to get the actual SDK version
    return await _getPlatformSDKInt();
  } catch (e) {
    debugPrint('Error getting Android SDK version: $e');
    // Default to a safe value that assumes modern Android
    return 29;
  }
}

/// Implementation to get Android SDK version
/// In a real app, replace this with device_info_plus plugin implementation
Future<int> _getPlatformSDKInt() async {
  // Add dependency: device_info_plus: ^9.0.0
  // Example implementation using device_info_plus:
  // final deviceInfo = DeviceInfoPlugin();
  // final androidInfo = await deviceInfo.androidInfo;
  // return androidInfo.version.sdkInt;

  // Placeholder implementation
  // Replace this with actual implementation using device_info_plus
  return 33; // Assumes Android 13 by default
}

/// Example usage function demonstrating how to handle permission results
Future<bool> handleStorageAccess() async {
  final hasPermission = await checkStoragePermission();

  if (hasPermission) {
    return true;
  } else {
    return false;
    // Show dialog explaining why permission is needed
  }
}
