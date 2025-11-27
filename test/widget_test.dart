import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tush/main.dart';

void main() {
  testWidgets('Auth flow smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify that we are on the Login screen.
    expect(find.text('Login'), findsWidgets); // Title and Button

    // Tap the 'Login' button.
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify that we are on the Home screen.
    expect(find.text('Welcome Home!'), findsOneWidget);
  });
}
