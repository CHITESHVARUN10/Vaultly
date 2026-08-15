import 'package:flutter/material.dart';
import 'package:filey/widgets/media_grid.dart';
import 'package:filey/services/media_service.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
var isPermissionGranted=false;
 PermissionState permission=PermissionState.notDetermined;
 List<AssetEntity> assets = [];
  final  mediaService = MediaService();
  @override
  void initState() {
    super.initState();
   _checkPermission();
   
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
  final loadedAssets = await mediaService.loadAssets();
  setState(() {
    assets = loadedAssets;
  });
}

    
   
  @override
  Widget build(BuildContext context) {
      Widget bodyContent;
  if (isPermissionGranted) {
    bodyContent =  MediaGrid(assets: assets);
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
    appBar: AppBar(title: const Text("Vaultly")),
    body: bodyContent,
  );
    
    
    
    
  
  }
}
  
  
