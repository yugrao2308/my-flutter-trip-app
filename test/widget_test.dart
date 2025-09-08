// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yourtrip/main.dart';

void main() {
  testWidgets('HomePage smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GoFlutterApp());

    // Verify that the app name is displayed.
    expect(find.text('GoFlutter'), findsOneWidget);

    // Verify that the booking card is displayed.
    expect(find.byType(BookingCard), findsOneWidget);

    // Scroll down to find the destination cards.
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
    await tester.pump();

    // Verify that the category cards are displayed.
    expect(find.text('Beach'), findsOneWidget);
    expect(find.text('Mountain'), findsOneWidget);
    expect(find.text('City'), findsOneWidget);
    expect(find.text('Forest'), findsOneWidget);
  });
}
