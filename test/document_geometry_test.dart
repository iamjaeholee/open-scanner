import 'package:open_scanner/document_geometry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

void main() {
  test('임의의 순서로 주어진 4개의 점을 [좌상, 우상, 우하, 좌하] 순서로 정렬한다', () {
    // 1. Arrange (준비)
    // 섞여 있는 점들: 우하(100,100), 좌하(0,100), 좌상(0,0), 우상(100,0)
    const unorderedPoints = [
      (100.0, 100.0),
      (0.0, 100.0),
      (0.0, 0.0),
      (100.0, 0.0),
    ];

    // 2. Act (실행)
    final ordered = orderPoints(unorderedPoints);

    // 3. Assert (검증)
    expect(ordered, [(0.0, 0.0), (100.0, 0.0), (100.0, 100.0), (0.0, 100.0)]);
  });

  test(
    'calculateScannedSize returns maximum width and height as rounded integer',
    () {
      const orderedPoints = [
        (0.0, 0.0),
        (100.0, 0.0),
        (120.0, 200.0),
        (0.0, 200.0),
      ];

      final calculated = calculateScannedSize(orderedPoints);
      expect(calculated, (width: 120, height: 201));
    },
  );

  test('getDestinationPoints returns rectangle corners matching the given dimensions', () {
    final [topLeft, topRight, bottomRight, bottomLeft] = getDestinationPoints(
      width: 120,
      height: 200,
    );

    expect(topLeft, (0.0, 0.0));
    expect(topRight, (120.0, 0.0));
    expect(bottomRight, (120.0, 200.0));
    expect(bottomLeft, (0.0, 200.0));
  });

  test(
    'createCropSpec creates a complete DocumentCropSpec from unordered points',
    () {
      const unorderedPoints = [
        (100.0, 100.0),
        (0.0, 100.0),
        (100.0, 0.0),
        (0.0, 0.0),
      ];

      final spec = createCropSpec(unorderedPoints);

      expect(spec.width, 100);
      expect(spec.height, 100);
      expect(spec.sourceCorners.first, (0.0, 0.0));
      expect(spec.destinationCorners.last, (0.0, 100.0));
    },
  );

  test('warpDocumentImage returns a rectified image from given source image and a valid crop spec', () {
    final sourceImage = img.Image(height: 100, width: 100);
    img.fill(sourceImage, color: img.ColorRgb8(255, 0, 0));

    final spec = createCropSpec([
      (0.0, 0.0),
      (50.0, 0.0),
      (0.0, 50.0),
      (50.0, 50.0),
    ]);

    final resultImage = warpDocumentImage(sourceImage: sourceImage, spec: spec);
    expect(resultImage.width, 50);
    expect(resultImage.height, 50);

    final pixel = resultImage.getPixel(0, 0);
    expect(pixel.r, 255);
    expect(pixel.g, 0);
    expect(pixel.b, 0);
  });

  test('warpDocumentImage rectifies a skewed quad into a flat rectangle', () {
    final sourceImage = img.Image(height: 100, width: 100);
    img.fill(sourceImage, color: img.ColorRgb8(0, 0, 0));
    sourceImage.setPixel(20, 10, img.ColorRgb8(255, 0, 0));
    sourceImage.setPixel(80, 10, img.ColorRgb8(0, 255, 0));
    sourceImage.setPixel(90, 90, img.ColorRgb8(0, 0, 255));
    sourceImage.setPixel(10, 90, img.ColorRgb8(255, 255, 255));

    final spec = createCropSpec([
      (20.0, 10.0),
      (80.0, 10.0),
      (90.0, 90.0),
      (10.0, 90.0),
    ]);

    final resultImage = warpDocumentImage(sourceImage: sourceImage, spec: spec);
    final tl = resultImage.getPixel(0, 0);
    expect(tl.r, 255);
    expect(tl.g, 0);
    expect(tl.b, 0);

    final tr = resultImage.getPixel(resultImage.width - 1, 0);
    expect(tr.g, 255);

    final br = resultImage.getPixel(
      resultImage.width - 1,
      resultImage.height - 1,
    );
    expect(br.b, 255);

    final bl = resultImage.getPixel(0, resultImage.height - 1);
    expect(bl.r, 255);
    expect(bl.g, 255);
    expect(bl.b, 255);
  });
}
