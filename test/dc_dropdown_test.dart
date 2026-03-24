import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('DCDropdown Tests', () {
    testWidgets('DCDropdown renders items correctly', (tester) async {
      final items = ['Option 1', 'Option 2', 'Option 3'];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCDropdown<String>(
              items: items,
              onChanged: (_) {},
              hintText: 'Select Option',
            ),
          ),
        ),
      );

      expect(find.text('Select Option'), findsOneWidget);
    });

    testWidgets('DCDropdown selects value correctly', (tester) async {
      String? selectedValue;
      final items = ['A', 'B', 'C'];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return DCDropdown<String>(
                  items: items,
                  value: selectedValue,
                  onChanged: (val) {
                    setState(() => selectedValue = val);
                  },
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(DCDropdown<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('B').last);
      await tester.pumpAndSettle();

      expect(selectedValue, equals('B'));
    });
  });
}
