import 'package:photo_manager/photo_manager.dart';

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
Future<List<AssetEntity>>loadAssets() async {
  List<AssetEntity> assets = [];
  // Get all albums
List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
  type: RequestType.common,
);

// Get assets from the first album
if (albums.isNotEmpty) {
  assets = await albums[0].getAssetListRange(
    start: 0,
    end: 10, // Fetch first 10 assets
  );
  
  
}   
  return assets;
}   

  
}