import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCTextDemo extends StatelessWidget {
  const DCTextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCText',
      children: [
        const SectionTitle('Font Sizes'),
        const DCText('DCFontSize.xxl (24)', fontSize: DCFontSize.xxl),
        const SizedBox(height: DCSpacing.sm),
        const DCText('DCFontSize.xl (20)', fontSize: DCFontSize.xl),
        const SizedBox(height: DCSpacing.sm),
        const DCText('DCFontSize.md (18)', fontSize: DCFontSize.md),
        const SizedBox(height: DCSpacing.sm),
        const DCText('DCFontSize.normal (16)', fontSize: DCFontSize.normal),
        const SizedBox(height: DCSpacing.sm),
        const DCText('DCFontSize.sm (14)', fontSize: DCFontSize.sm),
        const SizedBox(height: DCSpacing.sm),
        const DCText('DCFontSize.tiny (12)', fontSize: DCFontSize.tiny),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Font Weights'),
        const DCText('Bold (w700)', weight: FontWeight.w700),
        const SizedBox(height: DCSpacing.sm),
        const DCText('SemiBold (w600)', weight: FontWeight.w600),
        const SizedBox(height: DCSpacing.sm),
        const DCText('Medium (w500)', weight: FontWeight.w500),
        const SizedBox(height: DCSpacing.sm),
        const DCText('Regular (w400)', weight: FontWeight.w400),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Colors'),
        const DCText('Primary Color', color: DCColors.primary),
        const SizedBox(height: DCSpacing.sm),
        const DCText('Secondary Color', color: DCColors.secondary),
        const SizedBox(height: DCSpacing.sm),
        const DCText('Error Color', color: DCColors.error),
        const SizedBox(height: DCSpacing.sm),
        const DCText('Text Secondary', color: DCColors.textSecondary),
      ],
    );
  }
}
