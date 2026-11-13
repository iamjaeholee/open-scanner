import 'package:flutter/cupertino.dart';
import 'package:open_scanner/document_geometry.dart';

class CropController extends ChangeNotifier {
  final int imageWidth;
  final int imageHeight;
  late List<Point> corners;

  CropController({required this.imageWidth, required this.imageHeight}) {
    final dx = imageWidth * 0.1;
    final dy = imageHeight * 0.1;
    final x = imageWidth.toDouble();
    final y = imageHeight.toDouble();

    corners = [(dx, dy), (x - dx, dy), (x - dx, y - dy), (dx, y - dy)];
  }
}
