import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCButtonDemo extends StatelessWidget {
  const DCButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCButton',
      children: [
        const SectionTitle('Variants'),
        DCButton(
          onPressed: () {},
          label: 'Filled Button',
          variant: DCButtonVariant.filled,
        ),
        const SizedBox(height: DCSpacing.md),
        DCButton(
          onPressed: () {},
          label: 'Outlined Button',
          variant: DCButtonVariant.outlined,
        ),
        const SizedBox(height: DCSpacing.md),
        DCButton(
          onPressed: () {},
          label: 'Text Button',
          variant: DCButtonVariant.text,
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Sizes'),
        DCButton(onPressed: () {}, label: 'Small', size: DCButtonSize.small),
        const SizedBox(height: DCSpacing.md),
        DCButton(onPressed: () {}, label: 'Medium', size: DCButtonSize.medium),
        const SizedBox(height: DCSpacing.md),
        DCButton(onPressed: () {}, label: 'Large', size: DCButtonSize.large),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('With Icon'),
        DCButton(onPressed: () {}, label: 'With Icon', icon: Icons.send),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Full Width'),
        DCButton(onPressed: () {}, label: 'Full Width Button', fullWidth: true),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Loading'),
        DCButton(onPressed: () {}, label: 'Loading...', isLoading: true),
      ],
    );
  }
}
