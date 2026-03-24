import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCImageDemo extends StatelessWidget {
  const DCImageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCImage',
      children: [
        const SectionTitle('Network Image with Shimmer'),
        const DCImage(
          imageUrl: 'https://picsum.photos/seed/datc1/800/400',
          height: 200,
          borderRadius: BorderRadius.all(Radius.circular(DCSpacing.md)),
        ),
        const SizedBox(height: DCSpacing.lg),
        const SectionTitle('Circular Image'),
        const Center(
          child: DCImage(
            imageUrl: 'https://picsum.photos/seed/datc2/200/200',
            width: 100,
            height: 100,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        const SizedBox(height: DCSpacing.lg),
        const SectionTitle('BoxFit Variants'),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const DCImage(
                    imageUrl: 'https://picsum.photos/seed/datc3/200/300',
                    height: 150,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.all(
                      Radius.circular(DCSpacing.sm),
                    ),
                  ),
                  const SizedBox(height: DCSpacing.xs),
                  DCText('Cover', fontSize: DCFontSize.xs),
                ],
              ),
            ),
            const SizedBox(width: DCSpacing.md),
            Expanded(
              child: Column(
                children: [
                  const DCImage(
                    imageUrl: 'https://picsum.photos/seed/datc3/200/300',
                    height: 150,
                    fit: BoxFit.contain,
                    borderRadius: BorderRadius.all(
                      Radius.circular(DCSpacing.sm),
                    ),
                  ),
                  const SizedBox(height: DCSpacing.xs),
                  DCText('Contain', fontSize: DCFontSize.xs),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: DCSpacing.lg),
        const SectionTitle('Load Failed State'),
        const DCImage(
          imageUrl: 'https://invalid-url.com/image.png',
          height: 150,
          borderRadius: BorderRadius.all(Radius.circular(DCSpacing.md)),
        ),
      ],
    );
  }
}
