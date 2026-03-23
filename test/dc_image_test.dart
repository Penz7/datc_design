import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  group('DCImage Tests', () {
    testWidgets('renders normally and matches constraints', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DCImage(
              imageUrl: 'https://example.com/image.png',
              width: 150,
              height: 100,
            ),
          ),
        ),
      );

      // Verify the main container using its specific key
      final containerFinder = find.byKey(const Key('dc_image_container'));
      expect(containerFinder, findsOneWidget);
      
      final container = tester.widget<Container>(containerFinder);
      expect(container.constraints?.maxWidth, 150);
      expect(container.constraints?.maxHeight, 100);
      
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('wraps with ClipRRect when borderRadius is provided', (tester) async {
      const radius = BorderRadius.all(Radius.circular(12));
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DCImage(
              imageUrl: 'https://example.com/image.png',
              borderRadius: radius,
            ),
          ),
        ),
      );

      final clipFinder = find.byType(ClipRRect);
      expect(clipFinder, findsOneWidget);
      final clipRRect = tester.widget<ClipRRect>(clipFinder);
      expect(clipRRect.borderRadius, radius);
    });

    testWidgets('renders custom placeholder when loading', (tester) async {
      const placeholderKey = Key('custom_placeholder');
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DCImage(
              imageUrl: 'https://example.com/image.png',
              placeholder: SizedBox(key: placeholderKey),
            ),
          ),
        ),
      );

      expect(find.byKey(placeholderKey), findsOneWidget);
    });
  });
}
