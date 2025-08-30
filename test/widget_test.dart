// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:julsmzr_github_io/main.dart';

void main() {
  testWidgets('Landing shows navigation buttons', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('julsmzr'), findsOneWidget);
    expect(find.text('Projects'), findsOneWidget);
    expect(find.text('Games'), findsOneWidget);

  // Navigate to Projects
  await tester.tap(find.text('Projects'));
  await tester.pump(const Duration(milliseconds: 300));
  expect(find.text('Projects'), findsWidgets);

  // Pop manually
  Navigator.of(tester.element(find.text('Projects').first)).pop();
  await tester.pump(const Duration(milliseconds: 300));

  // Navigate to Games
  await tester.tap(find.text('Games'));
  await tester.pump(const Duration(milliseconds: 300));
  expect(find.text('Games'), findsWidgets);
  });
}
