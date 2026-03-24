import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCButtonDemo extends StatefulWidget {
  const DCButtonDemo({super.key});

  @override
  State<DCButtonDemo> createState() => _DCButtonDemoState();
}

class _DCButtonDemoState extends State<DCButtonDemo> {
  bool _isLoading = false;

  void _handlePress() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCButton',
      children: [
        const SectionTitle('Factories'),
        DCButton.fill(
          onPressed: _handlePress,
          label: _isLoading ? 'Please wait...' : 'Tap for Loading',
          isLoading: _isLoading,
          leadingIcon: const Icon(Icons.touch_app),
        ),
        const SizedBox(height: DCSpacing.md),
        DCButton.outline(
          onPressed: () {},
          label: 'Outline Button',
          trailingIcon: const Icon(Icons.arrow_forward),
        ),
        const SizedBox(height: DCSpacing.md),
        DCButton.custom(
          onPressed: () {},
          label: 'Custom Styles',
          backgroundColor: DCColors.secondary.withValues(alpha: 0.1),
          foregroundColor: DCColors.secondary,
          borderSide: const BorderSide(color: DCColors.secondary, width: 2),
          borderRadius: BorderRadius.circular(DCSpacing.xl),
          leadingIcon: const Icon(Icons.brush),
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Loading Customization'),
        Row(
          children: [
            DCButton.fill(
              onPressed: () {},
              label: 'Custom Color',
              isLoading: true,
              loadingColor: Colors.amber,
            ),
            const SizedBox(width: DCSpacing.sm),
            DCButton.outline(
              onPressed: () {},
              label: 'Custom Widget',
              isLoading: true,
              loadingWidget: const Text('🔥', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Both Icons'),
        DCButton.fill(
          onPressed: () {},
          label: 'Left & Right Icons',
          leadingIcon: const Icon(Icons.shopping_cart),
          trailingIcon: const Icon(Icons.chevron_right),
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Sizes'),
        Row(
          children: [
            DCButton.fill(
              onPressed: () {},
              label: 'Small',
              size: DCButtonSize.small,
            ),
            const SizedBox(width: DCSpacing.sm),
            DCButton.fill(
              onPressed: () {},
              label: 'Med',
              size: DCButtonSize.medium,
            ),
            const SizedBox(width: DCSpacing.sm),
            DCButton.fill(
              onPressed: () {},
              label: 'Large',
              size: DCButtonSize.large,
            ),
          ],
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Full Width'),
        DCButton.fill(
          onPressed: () {},
          label: 'Submit Order',
          fullWidth: true,
          trailingIcon: const Icon(Icons.payment),
        ),
      ],
    );
  }
}
