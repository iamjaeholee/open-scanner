import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_scanner/home_screen.dart';

void main() {
  testWidgets('HomeScreen displays app title and scan action buttons', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('OpenScanner'), findsOneWidget);
    expect(find.text('카메라로 촬영'), findsOneWidget);
    expect(find.text('갤러리에서 선택'), findsOneWidget);
  });
}
