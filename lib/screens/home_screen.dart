import 'package:flutter/material.dart';
import 'package:filey/widgets/media_grid.dart';
import 'package:filey/services/media_service.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:filey/screens/media_viewer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isPermissionGranted = false;
  PermissionState permission = PermissionState.notDetermined;
  List<AssetEntity> assets = [];
  final Set<int> _selectedIndices = {};

  bool get isSelectionMode => _selectedIndices.isNotEmpty;
  bool _isSelected(int index) => _selectedIndices.contains(index);
  final mediaService = MediaService();
  final ScrollController _scrollController = ScrollController();
  int start = 0;
  int currentLimit = 20;
  int end = 20;
  bool _isLoading = false;
  bool _hasMore = true;
  @override
  void initState() {
    super.initState();
    _checkPermission();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Prevent memory leaks
    super.dispose();
  }

void _onScroll() {
    // Check if user has scrolled within 200px of the bottom
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        _fetchNextPage();
      }
    }
  }

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MediaViewerScreen(assets: assets, initialIndex: index),
        ),
      );
    }
  }

  void _onItemLongPress(int index) {
    _toggleSelection(index);
  }

  // 3. Clear selection helper
  void _clearSelection() {
    setState(() {
      _selectedIndices.clear();
    });
  }

  Future<void> _checkPermission() async {
    final permission = await mediaService.requestPermission();

    setState(() {
      if (permission.isAuth || permission.hasAccess) {
        isPermissionGranted = true;
        _loadAssets();
      } else {
        isPermissionGranted = false;
      }
    });
  }

  Future<void> _loadAssets() async {
    final loadedAssets = await mediaService.loadAssets(start, currentLimit);
    setState(() {
      assets.addAll(loadedAssets);
      _isLoading = false;
    });
  }

  Future<void> _fetchNextPage() async {
    setState(() => _isLoading = true);
    start+=currentLimit;
    end+=currentLimit;
    // Fetch next batch
    final loadedAssets = await mediaService.loadAssets(start, end);
    setState(() {
      if (loadedAssets.isEmpty) {
        _hasMore = false;
      } else {
         assets.addAll(loadedAssets); // Append new batch to existing list
      }
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    if (isPermissionGranted) {
      bodyContent = MediaGrid(
        assets: assets,
        onItemTap: _onItemTap,
        onItemLongPress: _onItemLongPress,
        isSelected: _isSelected,
        isSelectionMode: isSelectionMode,
        selectedIndices: _selectedIndices,
        controller: _scrollController, 
        isLoading: _isLoading,
      );
    } else {
      bodyContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Vaultly needs access to your photos and videos."),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                mediaService.openSettings();
              },
              child: const Text("Open Settings"),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Grid"),
        actions: [
          if (isSelectionMode) ...[
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _clearSelection,
              tooltip: "Clear selection",
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // TODO: Handle delete logic
              },
              tooltip: "Delete",
            ),
          ],
        ],
      ),
      body: bodyContent,
    );
  }
}
