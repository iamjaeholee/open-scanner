import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:open_scanner/crop_controller.dart';

class CropScreen extends StatefulWidget {
  final img.Image sourceImage;
  final Uint8List imageBytes;
  final void Function(img.Image result)? onCropComplete;

  const CropScreen({
    super.key,
    required this.sourceImage,
    required this.imageBytes,
    this.onCropComplete,
  });

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  late final CropController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CropController(
      imageWidth: widget.sourceImage.width,
      imageHeight: widget.sourceImage.height,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('영역 선택')),
      body: Column(
        children: [
          Expanded(child: Image.memory(widget.imageBytes)),
          ElevatedButton(
            onPressed: () => widget.onCropComplete?.call(
              _controller.cropDocument(widget.sourceImage),
            ),
            child: const Text('스캔 완료'),
          ),
        ],
      ),
    );
  }
}
