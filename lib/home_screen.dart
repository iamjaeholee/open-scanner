import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OpenScanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(child: const Text('카메라로 촬영'), onPressed: () {}),
            const SizedBox(height: 16),
            ElevatedButton(child: const Text('갤러리에서 선택'), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
