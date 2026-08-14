import 'package:flutter/material.dart';

class MediaGrid extends StatelessWidget {
  MediaGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 10.0, // Space between rows
        crossAxisSpacing: 10.0, // Space between columns
        childAspectRatio: 1.0, // Width-to-height ratio of each tile
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(child: Center(child: Text('Item $index')));
      },
    );
  }
}
