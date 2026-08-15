import 'package:flutter/material.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:photo_manager/photo_manager.dart';


class MediaGrid extends StatelessWidget {
   const MediaGrid({super.key,required this.assets});
final List<AssetEntity> assets;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 10.0, // Space between rows
        crossAxisSpacing: 10.0, // Space between columns
        childAspectRatio: 1.0, // Width-to-height ratio of each tile
      ),
      itemCount: assets.length,
      itemBuilder: (context, index) {
        return  AssetEntityImage(
          assets[index],
          isOriginal: false,
          thumbnailSize: const ThumbnailSize.square(200),
        );
      },
    );
  }
}
