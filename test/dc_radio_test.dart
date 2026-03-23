import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('DCRadio and DCRadioItem Tests', () {
    testWidgets('DCRadio renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCRadio<int>(value: 1, groupValue: 1, onChanged: (val) {}),
          ),
        ),
      );

      final radioFinder = find.byType(Radio<int>);
      expect(radioFinder, findsOneWidget);
    });

    testWidgets('DCRadioItem renders with title and reacts to tap', (
      tester,
    ) async {
      int? selectedValue = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCRadioItem<int>(
              value: 1,
              groupValue: selectedValue,
              title: 'Radio Item',
              onChanged: (val) {
                selectedValue = val;
              },
            ),
          ),
        ),
      );

      expect(find.text('Radio Item'), findsOneWidget);
      await tester.tap(find.byType(DCRadioItem<int>));
      expect(selectedValue, 1);
    });

    testWidgets('DCListRadio displays multiple items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCListRadio<int>(
              groupValue: 1,
              onChanged: (val) {},
              items: [
                DCRadioOption(value: 1, title: 'Option 1'),
                DCRadioOption(value: 2, title: 'Option 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.byType(Radio<int>), findsNWidgets(2));
    });
  });
}
