import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/material.dart';
class MediaService {

  Future<PermissionState> requestPermission() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
       

    return permission;
  }
  
// Inside MediaService class
  Future<void> openSettings() async {
    await PhotoManager.openSetting();
  }


}