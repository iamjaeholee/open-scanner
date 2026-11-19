import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onCameraTap, this.onGalleryTap});
  final VoidCallback? onCameraTap;
  final VoidCallback? onGalleryTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OpenScanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onCameraTap,
              child: const Text('카메라로 촬영'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onGalleryTap,
              child: const Text('갤러리에서 선택'),
            ),
          ],
        ),
      ),
    );
  }
}
