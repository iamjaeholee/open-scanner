import 'dart:math';

typedef Point = (double, double);

List<Point> orderPoints(List<Point> pts) {
  assert(pts.length == 4, "Points must have 4 point");
  Point topLeft = pts[0];
  double minSum = pts[0].$1 + pts[0].$2;
  Point topRight = pts[0];
  double maxSum = pts[0].$1 + pts[0].$2;
  Point bottomRight = pts[0];
  double minDiff = pts[0].$2 - pts[0].$1;
  Point bottomLeft = pts[0];
  double maxDiff = pts[0].$2 - pts[0].$1;

  for (final point in pts) {
    final sum = point.$1 + point.$2;
    final diff = point.$2 - point.$1;

    if (minSum > sum) {
      topLeft = point;
      minSum = sum;
    }

    if (maxSum < sum) {
      bottomRight = point;
      maxSum = sum;
    }

    if (minDiff > diff) {
      topRight = point;
      minDiff = diff;
    }

    if (maxDiff < diff) {
      bottomLeft = point;
      maxDiff = diff;
    }
  }

  return [topLeft, topRight, bottomRight, bottomLeft];
}

double calculateDistance(Point a, Point b) {
  final dx = b.$1 - a.$1;
  final dy = b.$2 - a.$2;
  return sqrt(dx * dx + dy * dy);
}

({int width, int height}) calculateScannedSize(List<Point> pts) {
  assert(pts.length == 4, "Points must have 4 point");
  final [topLeft, topRight, bottomRight, bottomLeft] = pts;
  final topWidth = calculateDistance(topLeft, topRight);
  final bottomWidth = calculateDistance(bottomLeft, bottomRight);
  final leftHeight = calculateDistance(topLeft, bottomLeft);
  final rightHeight = calculateDistance(topRight, bottomRight);

  return (
    width: max(topWidth, bottomWidth).round(),
    height: max(leftHeight, rightHeight).round(),
  );
}

List<Point> getDestinationPoints({required int width, required int height}) {
  assert(width > 0 && height > 0, 'width and height must be positive');
  final dWidth = width.toDouble();
  final dHeight = height.toDouble();
  final topLeft = (0.0, 0.0);
  final topRight = (dWidth, 0.0);
  final bottomRight = (dWidth, dHeight);
  final bottomLeft = (0.0, dHeight);

  return [topLeft, topRight, bottomRight, bottomLeft];
}
