import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';

class DCListDemo extends StatefulWidget {
  const DCListDemo({super.key});

  @override
  State<DCListDemo> createState() => _DCListDemoState();
}

class _DCListDemoState extends State<DCListDemo> {
  final List<String> _items = List.generate(20, (i) => 'Custom Item ${i + 1}');
  bool _isLoadingMore = false;
  bool _hasMoreData = true;

  Future<void> _onRefresh() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _items.clear();
      _items.addAll(List.generate(20, (i) => 'Custom Item ${i + 1}'));
      _hasMoreData = true;
    });
  }

  Future<void> _onLoadMore() async {
    setState(() {
      _isLoadingMore = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() {
      final currentLength = _items.length;
      _items.addAll(
        List.generate(10, (i) => 'Custom Item ${currentLength + i + 1}'),
      );

      _isLoadingMore = false;
      // Stop loading after 50 items
      if (_items.length >= 50) {
        _hasMoreData = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DCText(
          'DCList & DCListItem',
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
              'Pull down to refresh, scroll to bottom to load more.',
              fontSize: DCFontSize.sm,
              color: DCColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: DCList.separated(
              itemCount: _items.length,
              onRefresh: _onRefresh,
              onLoadMore: _onLoadMore,
              isLoadingMore: _isLoadingMore,
              hasMoreData: _hasMoreData,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = _items[index];
                return DCListItem(
                  title: item,
                  subtitle: 'This is a subtitle for $item',
                  leading: CircleAvatar(
                    backgroundColor: DCColors.primary.withValues(alpha: 0.1),
                    child: DCText(
                      '${index + 1}',
                      color: DCColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: DCColors.gray400,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Tapped $item')));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
