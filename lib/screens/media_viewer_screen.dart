import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class MediaViewerScreen extends StatefulWidget {
  const MediaViewerScreen({
    super.key,
    required this.assets,
    required this.initialIndex,
  });
  final List<AssetEntity> assets;
  final int initialIndex;

  @override
  State<MediaViewerScreen> createState() => _MediaViewerScreenState();
}

class _MediaViewerScreenState extends State<MediaViewerScreen> {
    late final PageController _pageController;
  late int _currentPage;
  @override
  void initState() {

    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark gallery theme
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha:0.8),
        foregroundColor: Colors.white,
        title: Text('${_currentPage + 1} of ${widget.assets.length}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show file metadata bottom sheet or dialog
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.assets.length,
        onPageChanged: (newIndex) {
          setState(() {
            _currentPage = newIndex;
          });
        },
        itemBuilder: (context, index) {
          final doc = widget.assets[index];
          return Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: AssetEntityImage(
                doc,
                fit: BoxFit
                    .contain, // In Vaultly, use AssetEntityImage(asset, isOriginal: true)
              ),
            ),
          );
        },
      ),
    );
  }

}
