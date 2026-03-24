import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  group('DCList Tests with pull_to_refresh', () {
    testWidgets('renders basic children list', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCList(
              children: [const Text('Item 1'), const Text('Item 2')],
            ),
          ),
        ),
      );

      expect(find.byType(DCList), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      // SmartRefresher should be part of the widget tree
      expect(find.byType(SmartRefresher), findsOneWidget);
    });

    testWidgets('renders builder list', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCList.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Text('Builder Item $index'),
            ),
          ),
        ),
      );

      expect(find.text('Builder Item 0'), findsOneWidget);
      expect(find.text('Builder Item 1'), findsOneWidget);
      expect(find.text('Builder Item 2'), findsOneWidget);
    });

    testWidgets('renders separated list', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCList.separated(
              itemCount: 2,
              itemBuilder: (context, index) => Text('Item $index'),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('pull to refresh invokes onRefresh', (tester) async {
      bool refreshed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCList(
              onRefresh: () async {
                refreshed = true;
              },
              children: const [Text('Item 1')],
            ),
          ),
        ),
      );

      // Perform swipe down to pull-to-refresh
      await tester.fling(find.text('Item 1'), const Offset(0, 300), 1000);
      await tester.pumpAndSettle();

      expect(refreshed, isTrue);
    });

    testWidgets('shows loading footer and triggers load more', (tester) async {
      bool loadedMore = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              child: DCList.builder(
                itemCount: 5,
                hasMoreData: true,
                onLoadMore: () async {
                  loadedMore = true;
                },
                itemBuilder: (context, index) =>
                    SizedBox(height: 100, child: Text('Item $index')),
              ),
            ),
          ),
        ),
      );

      // Scroll up to trigger load more
      await tester.drag(find.text('Item 0'), const Offset(0, -600));
      await tester.pumpAndSettle();

      expect(loadedMore, isTrue);
    });

    testWidgets('shows custom header and footer', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCList(
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
            body: DCList.builder(
              itemCount: 0,
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
