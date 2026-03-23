import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('DCTextField Tests', () {
    testWidgets('renders normally', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DCTextField(hintText: 'Enter name', labelText: 'Name'),
          ),
        ),
      );

      expect(find.byType(DCTextField), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Enter name'), findsOneWidget);
    });

    testWidgets('allows entering text', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DCTextField(controller: controller)),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello Datc');
      expect(controller.text, 'Hello Datc');
    });

    testWidgets('renders error text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DCTextField(errorText: 'Invalid email')),
        ),
      );

      expect(find.text('Invalid email'), findsOneWidget);
    });
  });

  group('DCTextFieldSearch Tests', () {
    testWidgets('debounces search input', (tester) async {
      String? lastSearch;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCTextFieldSearch(
              debounceDuration: const Duration(milliseconds: 100),
              onSearch: (val) {
                lastSearch = val;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'A');
      await tester.enterText(find.byType(TextField), 'AB');

      // Right after typing, the callback shouldn't be called yet
      expect(lastSearch, null);

      // Wait for debounce duration
      await tester.pump(const Duration(milliseconds: 150));

      // After debounce, the callback should be called with the latest value
      expect(lastSearch, 'AB');
    });

    testWidgets('clears input when clear button is tapped', (tester) async {
      String? lastSearch;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCTextFieldSearch(
              debounceDuration: const Duration(milliseconds: 50),
              onSearch: (val) {
                lastSearch = val;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Test');
      await tester.pump(const Duration(milliseconds: 100)); // Wait for debounce
      expect(lastSearch, 'Test');

      // Tap clear icon
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump(const Duration(milliseconds: 100)); // Wait for debounce

      // The text field should be empty, and 'onSearch' called with ''
      expect(find.text('Test'), findsNothing);
      expect(lastSearch, '');
    });
  });
}
