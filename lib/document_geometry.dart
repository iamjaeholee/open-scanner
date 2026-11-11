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
