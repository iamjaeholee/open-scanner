import 'package:open_scanner/document_geometry.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
