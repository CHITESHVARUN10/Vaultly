import 'package:flutter/material.dart';

import 'package:photo_manager/photo_manager.dart';

import '../models/media_item.dart';

class MediaGrid extends StatefulWidget {
  const MediaGrid({super.key, required this.assets});
  final List<AssetEntity> assets;

  @override
  State<MediaGrid> createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  final Set<int> _selectedIndices = {};

  bool get isSelectionMode => _selectedIndices.isNotEmpty;
  bool _isSelected(int index) => _selectedIndices.contains(index);

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _onItemTap(int index) {
    if (isSelectionMode) {
      _toggleSelection(index);
    } else {
      // Normal mode: Preview dialog will be handled here
    }
  }

  void _onItemLongPress(int index) {
    _toggleSelection(index);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 10.0, // Space between rows
        crossAxisSpacing: 10.0, // Space between columns
        childAspectRatio: 1.0, // Width-to-height ratio of each tile
      ),
      itemCount: widget.assets.length,
      itemBuilder: (context, index) {
        return MediaItem(
          asset: widget.assets[index],
          isSelected: _isSelected(index),
          onTap: () => _onItemTap(index),
          onLongPress: () => _onItemLongPress(index),
        );
      },
    );
  }
}
