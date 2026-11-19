import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:open_scanner/crop_screen.dart';

void main() {
  testWidgets(
    'CropScreen displays sourceImage and triggers onCropComplete when the scan button is tapped',
    (tester) async {
      final sourceImage = img.Image(width: 100, height: 100);
      final imageBytes = Uint8List.fromList(img.encodePng(sourceImage));
      img.Image? croppedResult;

      await tester.pumpWidget(
        MaterialApp(
          home: CropScreen(
            sourceImage: sourceImage,
            imageBytes: imageBytes,
            onCropComplete: (result) => croppedResult = result,
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.text('스캔 완료'), findsOneWidget);

      await tester.tap(find.text('스캔 완료'));
      await tester.pump();

      expect(croppedResult, isNotNull);
      expect(croppedResult!.width, 80);
      expect(croppedResult!.height, 80);
    },
  );
}
