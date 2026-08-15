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
Future<List<AssetEntity>>loadAssets(int page, int size) async {
  List<AssetEntity> assets = [];
  // Get all albums
List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
  type: RequestType.common,
);

// Get assets from the first album
if (albums.isNotEmpty) {
  assets = await albums[0].getAssetListRange(
    start: page,
    end: size, // Fetch first 10 assets
  );
  
  
}   
  return assets;
}   
// Inside MediaService
  Map<DateTime, List<AssetEntity>> groupAssetsByDate(List<AssetEntity> assets) {
    final Map<DateTime, List<AssetEntity>> grouped = {};

    for (final asset in assets) {
      final date = asset.createDateTime;
      // Normalize to date-only (00:00:00)
      final dateKey = DateTime(date.year, date.month, date.day);

      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(asset);
    }

    return grouped;
  }

  
}