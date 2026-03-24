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
        DCText('DCFontSize.xxl (24)', fontSize: DCFontSize.xxl),
        const SizedBox(height: DCSpacing.sm),
        DCText('DCFontSize.xl (20)', fontSize: DCFontSize.xl),
        const SizedBox(height: DCSpacing.sm),
        DCText('DCFontSize.md (18)', fontSize: DCFontSize.md),
        const SizedBox(height: DCSpacing.sm),
        DCText('DCFontSize.normal (16)', fontSize: DCFontSize.normal),
        const SizedBox(height: DCSpacing.sm),
        DCText('DCFontSize.sm (14)', fontSize: DCFontSize.sm),
        const SizedBox(height: DCSpacing.sm),
        DCText('DCFontSize.tiny (12)', fontSize: DCFontSize.tiny),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Named Constructors'),
        DCText.bold('DCText.bold (w700)'),
        const SizedBox(height: DCSpacing.sm),
        DCText.semiBold('DCText.semiBold (w600)'),
        const SizedBox(height: DCSpacing.sm),
        DCText.medium('DCText.medium (w500)'),
        const SizedBox(height: DCSpacing.sm),
        DCText.regular('DCText.regular (w400)'),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Colors'),
        DCText('Primary Color', color: DCColors.primary),
        const SizedBox(height: DCSpacing.sm),
        DCText('Secondary Color', color: DCColors.secondary),
        const SizedBox(height: DCSpacing.sm),
        DCText('Error Color', color: DCColors.error),
        const SizedBox(height: DCSpacing.sm),
        DCText('Text Secondary', color: DCColors.textSecondary),
      ],
    );
  }
}
