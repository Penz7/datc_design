import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCRichTextDemo extends StatelessWidget {
  const DCRichTextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCRichText',
      children: [
        const SectionTitle('Basic Rich Text'),
        const DCRichText(
          children: [
            TextSpan(text: 'Basic '),
            TextSpan(
              text: 'Rich ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: 'Text',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Design System Styled'),
        DCRichText(
          baseFontSize: DCFontSize.md,
          baseWeight: FontWeight.w500,
          children: [
            const TextSpan(text: 'Check out our '),
            TextSpan(
              text: 'Design System',
              style: TextStyle(
                color: DCColors.primary,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
            const TextSpan(text: ' for more widgets!'),
          ],
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Colors & Custom Sizes'),
        const DCRichText(
          baseColor: DCColors.textSecondary,
          children: [
            TextSpan(text: 'Status: '),
            TextSpan(
              text: 'Success ✅',
              style: TextStyle(
                color: DCColors.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Text overflowing'),
        const SizedBox(
          width: 200,
          child: DCRichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            children: [
              TextSpan(
                text:
                    'This is a very long text that will eventually overflow the container...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
