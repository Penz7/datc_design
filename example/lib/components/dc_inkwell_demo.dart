import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCInkWellDemo extends StatelessWidget {
  const DCInkWellDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCInkWell',
      children: [
        const SectionTitle('Basic'),
        DCInkWell(onTap: () {}, label: 'Tap me'),
        const SizedBox(height: DCSpacing.md),
        const SectionTitle('With Icon'),
        DCInkWell(onTap: () {}, label: 'Settings', icon: Icons.settings),
        const SizedBox(height: DCSpacing.md),
        const SectionTitle('With Trailing'),
        DCInkWell(
          onTap: () {},
          label: 'Navigate',
          icon: Icons.explore,
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: DCColors.gray400,
          ),
        ),
        const SizedBox(height: DCSpacing.md),
        const SectionTitle('DCInkWellVariant (custom child)'),
        DCInkWellVariant(
          onTap: () {},
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: DCColors.secondary,
                  borderRadius: BorderRadius.circular(DCSpacing.sm),
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: DCSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DCText('Custom Layout', fontWeight: FontWeight.w600),
                    DCText(
                      'Using DCInkWellVariant',
                      fontSize: DCFontSize.tiny,
                      color: DCColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
