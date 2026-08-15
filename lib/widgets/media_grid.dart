import 'package:flutter/material.dart';

import 'package:photo_manager/photo_manager.dart';
import '../services/media_service.dart';
import '../models/media_item.dart';



class MediaGrid extends StatelessWidget {



  const MediaGrid({
    super.key,
    required this.assets,
    required this.selectedIndices,
    required this.onItemTap,
    required this.onItemLongPress,
    required this.isSelectionMode,
    required this.isSelected,
    required this.controller,
    required this.isLoading,
  });
  final List<AssetEntity> assets;
  final Set<int> selectedIndices;
  final Function onItemTap;
  final Function onItemLongPress;
  final bool isSelectionMode;
  final Function isSelected;
  final ScrollController controller;
  final bool isLoading;

 



  @override
  Widget build(BuildContext context) {
    // 1. Group the assets by date
    final groupedAssets = MediaService().groupAssetsByDate(assets);
    return CustomScrollView(
      controller: controller,
      slivers: [
        // 2. Loop through each date section
        for (final entry in groupedAssets.entries) ...[
          // Date Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                "${entry.key.day}/${entry.key.month}/${entry.key.year}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          // Photos Grid for this date
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns looks great with headers
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final asset = entry.value[index];
              // Find global index in assets list (for selection)
              final globalIndex = assets.indexOf(asset);
              return MediaItem(
                asset: asset,
                isSelected: isSelected(globalIndex),
                onTap: () => onItemTap(globalIndex),
                onLongPress: () => onItemLongPress(globalIndex),
              );
            }, childCount: entry.value.length),
          ),
        ],
        // 3. Bottom Loading Spinner
        if (isLoading)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
