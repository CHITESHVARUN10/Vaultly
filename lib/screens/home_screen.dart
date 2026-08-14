import 'package:flutter/material.dart';
import 'package:filey/widgets/media_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("valtly")),
      body: MediaGrid(),
    );
  }
}
