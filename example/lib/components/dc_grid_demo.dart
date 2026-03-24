import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:datc_design/datc_design.dart';

class DCGridDemo extends StatefulWidget {
  const DCGridDemo({super.key});

  @override
  State<DCGridDemo> createState() => _DCGridDemoState();
}

class _DCGridDemoState extends State<DCGridDemo> {
  final List<String> _items = List.generate(20, (i) => 'Grid Item ${i + 1}');
  bool _hasMoreData = true;

  Future<void> _onRefresh() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _items.clear();
      _items.addAll(List.generate(20, (i) => 'Grid Item ${i + 1}'));
      _hasMoreData = true;
    });
  }

  Future<void> _onLoadMore() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() {
      final currentLength = _items.length;
      _items.addAll(
        List.generate(10, (i) => 'Grid Item ${currentLength + i + 1}'),
      );

      // Stop loading after 60 items
      if (_items.length >= 60) {
        _hasMoreData = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DCText(
          'DCGrid',
          fontSize: DCFontSize.xl,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: DCColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(DCSpacing.md),
            color: DCColors.gray100,
            width: double.infinity,
            child: DCText(
              'Pull down to refresh, scroll down to load more.',
              fontSize: DCFontSize.sm,
              color: DCColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: DCGrid.builder(
              itemCount: _items.length,
              onRefresh: _onRefresh,
              onLoadMore: _onLoadMore,
              hasMoreData: _hasMoreData,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: DCSpacing.md,
                mainAxisSpacing: DCSpacing.md,
                childAspectRatio: 0.8,
              ),
              header: const WaterDropMaterialHeader(
                backgroundColor: DCColors.primary,
                color: Colors.white,
              ),
              footer: ClassicFooter(
                loadingText: 'Loading more...',
                noDataText: 'You reached the end!',
                textStyle: const TextStyle(
                  color: DCColors.textSecondary,
                  fontSize: DCFontSize.sm,
                ),
                loadingIcon: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              itemBuilder: (context, index) {
                final item = _items[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DCSpacing.sm),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: DCColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: DCText(
                          '${index + 1}',
                          color: DCColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: DCSpacing.md),
                      DCText(item, fontWeight: FontWeight.w600),
                      const SizedBox(height: DCSpacing.xs),
                      DCText(
                        'Details for $item',
                        fontSize: DCFontSize.tiny,
                        color: DCColors.textSecondary,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
