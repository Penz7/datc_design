import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  group('DCGrid Tests with pull_to_refresh', () {
    testWidgets('renders basic children grid', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: const [Text('Item 1'), Text('Item 2')],
            ),
          ),
        ),
      );

      expect(find.byType(DCGrid), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.byType(SmartRefresher), findsOneWidget);
    });

    testWidgets('renders builder grid', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCGrid.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => Text('Builder Item $index'),
            ),
          ),
        ),
      );

      expect(find.text('Builder Item 0'), findsOneWidget);
      expect(find.text('Builder Item 1'), findsOneWidget);
      expect(find.text('Builder Item 2'), findsOneWidget);
      expect(find.text('Builder Item 3'), findsOneWidget);
    });

    testWidgets('pull to refresh invokes onRefresh', (tester) async {
      bool refreshed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              onRefresh: () async {
                refreshed = true;
              },
              children: const [Text('Item 1')],
            ),
          ),
        ),
      );

      // Perform swipe down
      await tester.fling(find.text('Item 1'), const Offset(0, 300), 1000);
      await tester.pumpAndSettle();

      expect(refreshed, isTrue);
    });

    testWidgets('shows custom header and footer', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              onRefresh: () async {},
              onLoadMore: () async {},
              hasMoreData: true,
              header: const WaterDropHeader(),
              footer: const ClassicFooter(loadingText: 'Loading...'),
              children: const [Text('Item 1')],
            ),
          ),
        ),
      );

      final smartRefresher = tester.widget<SmartRefresher>(
        find.byType(SmartRefresher),
      );
      expect(smartRefresher.header, isA<WaterDropHeader>());
      expect(smartRefresher.footer, isA<ClassicFooter>());
    });

    testWidgets('empty widget displays when itemCount is 0', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCGrid.builder(
              itemCount: 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => const SizedBox(),
              emptyWidget: const Text('No items found'),
            ),
          ),
        ),
      );

      expect(find.text('No items found'), findsOneWidget);
    });
  });
}
