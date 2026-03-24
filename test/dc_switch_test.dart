import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('DCSwitch Tests', () {
    testWidgets('renders with required params', (tester) async {
      bool value = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCSwitch(value: value, onChanged: (v) => value = v),
          ),
        ),
      );
      expect(find.byType(DCSwitch), findsOneWidget);
    });

    testWidgets('toggles value on tap', (tester) async {
      bool value = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => DCSwitch(
                value: value,
                onChanged: (v) => setState(() => value = v),
              ),
            ),
          ),
        ),
      );

      expect(value, false);
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();
      expect(value, true);
    });

    testWidgets('does not toggle when disabled', (tester) async {
      bool value = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCSwitch(
              value: value,
              onChanged: (v) => value = v,
              isDisabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();
      expect(value, false);
    });

    testWidgets('renders labeled switch', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCSwitch.labeled(
              value: true,
              onChanged: (_) {},
              label: 'Enable notifications',
            ),
          ),
        ),
      );
      expect(find.text('Enable notifications'), findsOneWidget);
      expect(find.byType(DCSwitch), findsOneWidget);
    });

    testWidgets('renders inner ON/OFF labels', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCSwitch(
              value: true,
              onChanged: (_) {},
              onLabel: 'ON',
              offLabel: 'OFF',
            ),
          ),
        ),
      );
      expect(find.text('ON'), findsOneWidget);
    });

    testWidgets('renders in all sizes', (tester) async {
      for (final size in DCSwitchSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DCSwitch(value: false, onChanged: (_) {}, size: size),
            ),
          ),
        );
        expect(find.byType(DCSwitch), findsOneWidget);
      }
    });

    testWidgets('label position leading renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCSwitch.labeled(
              value: false,
              onChanged: (_) {},
              label: 'Dark Mode',
              labelPosition: DCSwitchLabelPosition.leading,
            ),
          ),
        ),
      );
      expect(find.text('Dark Mode'), findsOneWidget);
    });

    testWidgets('custom colors apply without error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCSwitch(
              value: true,
              onChanged: (_) {},
              activeTrackColor: Colors.red,
              activeThumbColor: Colors.yellow,
              inactiveTrackColor: Colors.grey,
              inactiveThumbColor: Colors.white,
            ),
          ),
        ),
      );
      expect(find.byType(DCSwitch), findsOneWidget);
    });
  });
}
