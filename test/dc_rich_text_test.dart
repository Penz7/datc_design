import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('DCRichText Tests', () {
    testWidgets('renders with base styles and children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCRichText(
              baseFontSize: 20,
              children: [
                TextSpan(text: 'Hello '),
                TextSpan(
                  text: 'World',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(DCRichText), findsOneWidget);

      final richText = tester.widget<RichText>(find.byType(DCRichText));
      final rootSpan = richText.text as TextSpan;

      // Check base style
      expect(rootSpan.style?.fontSize, 20);
      expect(rootSpan.style?.color, DCColors.textPrimary);

      // Check children
      expect(rootSpan.children?.length, 2);
      expect(
        (rootSpan.children![1] as TextSpan).style?.fontWeight,
        FontWeight.bold,
      );
    });

    testWidgets('respects custom base color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCRichText(
              baseColor: Colors.red,
              children: [TextSpan(text: 'Red Text')],
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(DCRichText));
      final rootSpan = richText.text as TextSpan;
      expect(rootSpan.style?.color, Colors.red);
    });
  });
}
