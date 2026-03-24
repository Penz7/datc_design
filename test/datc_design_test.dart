import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  test('DCColors primary color', () {
    expect(DCColors.primary.toARGB32(), equals(0xFF6366F1));
  });

  group('DCButton Tests', () {
    testWidgets('renders label correctly', (tester) async {
      void onPressed() {}

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCButton.fill(onPressed: onPressed, label: 'Test Button'),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('shows loading indicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCButton.fill(
              onPressed: dummyOnPressed,
              label: 'Loading...',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsNothing);
    });

    testWidgets('calls onPressed when pressed', (tester) async {
      var pressedCount = 0;
      void onPressed() => pressedCount++;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCButton.fill(onPressed: onPressed, label: 'Press Me'),
          ),
        ),
      );

      await tester.tap(find.byType(DCButton));
      await tester.pump();

      expect(pressedCount, 1);
    });
  });

  group('DCText Tests', () {
    testWidgets('renders text with custom size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: DCText('Test Text', fontSize: 24.0))),
      );

      expect(find.text('Test Text'), findsOneWidget);
    });
  });
}

void dummyOnPressed() {}
