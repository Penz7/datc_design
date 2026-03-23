import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('DCCheckbox and DCCheckboxItem Tests', () {
    testWidgets('DCCheckbox renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DCCheckbox(value: true, onChanged: (val) {})),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);
      expect(checkboxFinder, findsOneWidget);
    });

    testWidgets('DCCheckboxItem renders with title and reacts to tap', (
      tester,
    ) async {
      bool? selectedValue = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCCheckboxItem(
              value: selectedValue,
              title: 'Checkbox Item',
              onChanged: (val) {
                selectedValue = val;
              },
            ),
          ),
        ),
      );

      expect(find.text('Checkbox Item'), findsOneWidget);
      await tester.tap(find.byType(DCCheckboxItem));
      expect(selectedValue, true);
    });

    testWidgets('DCListCheckbox displays multiple items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCListCheckbox(
              items: [
                DCCheckboxOption(value: true, title: 'Option A'),
                DCCheckboxOption(value: false, title: 'Option B'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Option A'), findsOneWidget);
      expect(find.text('Option B'), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(2));
    });
  });
}
