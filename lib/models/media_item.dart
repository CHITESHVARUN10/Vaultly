import 'package:flutter/material.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaItem extends StatelessWidget {
 const MediaItem({
    super.key,
    required this.asset,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  });
  final AssetEntity asset;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Positioned.fill(
            child: AssetEntityImage(
              asset,
              isOriginal: false,
              thumbnailSize: const ThumbnailSize.square(500),
              fit: BoxFit.cover, // Fills the entire grid square
            ),
          ),
         if (isSelected)
            const Positioned(
              top: 8,
              right: 8,
              child: Icon(Icons.check_circle, color: Colors.blue),
            )
      
          else if (asset.type == AssetType.video)
            const Positioned(
              bottom: 8,
              left: 8,
              child: Icon(Icons.play_circle_fill, color: Colors.white),
            )
          else
            const Positioned(
              child: Icon(Icons.image, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
