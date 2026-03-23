import 'package:flutter/material.dart';
import '../constants/index.dart';
import 'dc_text.dart';

/// DC Custom List with consistent spacing
class DCList extends StatelessWidget {
  const DCList({
    super.key,
    required this.items,
    this.itemBuilder,
    this.separatorBuilder,
  });

  final List<Widget> items;
  final Widget Function(BuildContext, int)? itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(DCSpacing.md),
      itemCount: items.length,
      separatorBuilder:
          separatorBuilder ??
          (context, index) => Divider(color: DCColors.gray300),
      itemBuilder:
          itemBuilder ??
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: DCSpacing.sm),
            child: items[index],
          ),
    );
  }
}

/// Simple ListItem widget - uses DCFontSize
class DCListItem extends StatelessWidget {
  const DCListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DCSpacing.sm),
        child: Padding(
          padding: const EdgeInsets.all(DCSpacing.md),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: DCSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DCText(title, fontSize: DCFontSize.normal),
                    if (subtitle != null)
                      DCText(subtitle!, fontSize: DCFontSize.tiny),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
