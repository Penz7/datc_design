import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCRadioDemo extends StatefulWidget {
  const DCRadioDemo({super.key});

  @override
  State<DCRadioDemo> createState() => _DCRadioDemoState();
}

class _DCRadioDemoState extends State<DCRadioDemo> {
  int? _singleValue = 1;
  String? _groupValue = 'flutter';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCRadio',
      children: [
        const SectionTitle('DCRadioItem (standalone)'),
        DCRadioItem<int>(
          value: 1,
          groupValue: _singleValue,
          title: 'Option 1',
          subtitle: 'First option',
          onChanged: (val) => setState(() => _singleValue = val),
        ),
        DCRadioItem<int>(
          value: 2,
          groupValue: _singleValue,
          title: 'Option 2',
          subtitle: 'Second option',
          onChanged: (val) => setState(() => _singleValue = val),
        ),
        DCRadioItem<int>(
          value: 3,
          groupValue: _singleValue,
          title: 'Option 3',
          subtitle: 'Third option',
          onChanged: (val) => setState(() => _singleValue = val),
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('DCListRadio (grouped)'),
        DCListRadio<String>(
          groupValue: _groupValue,
          onChanged: (val) => setState(() => _groupValue = val),
          items: [
            DCRadioOption(
              value: 'flutter',
              title: 'Flutter',
              subtitle: 'Cross-platform UI toolkit',
            ),
            DCRadioOption(
              value: 'react',
              title: 'React Native',
              subtitle: 'JavaScript framework',
            ),
            DCRadioOption(
              value: 'kotlin',
              title: 'Kotlin Multiplatform',
              subtitle: 'JetBrains solution',
            ),
          ],
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Trailing Affinity'),
        DCRadioItem<int>(
          value: 1,
          groupValue: 1,
          title: 'Radio on the right',
          controlAffinity: ListTileControlAffinity.trailing,
          onChanged: (_) {},
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Custom Icons (Icons/Images)'),
        DCRadioItem<int>(
          value: 1,
          groupValue: _singleValue,
          title: 'Custom Icon Pair',
          subtitle: 'Uses Check vs Circle icons',
          activeIcon: const Icon(
            Icons.check_circle,
            color: DCColors.secondary,
            size: 24,
          ),
          inactiveIcon: const Icon(
            Icons.circle_outlined,
            color: DCColors.gray300,
            size: 24,
          ),
          onChanged: (val) => setState(() => _singleValue = val),
        ),
        DCRadioItem<int>(
          value: 2,
          groupValue: _singleValue,
          title: 'Another Icon Pair',
          activeIcon: const Icon(
            Icons.favorite,
            color: DCColors.error,
            size: 24,
          ),
          inactiveIcon: const Icon(
            Icons.favorite_border,
            color: DCColors.gray300,
            size: 24,
          ),
          onChanged: (val) => setState(() => _singleValue = val),
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Customizable Styles'),
        DCRadioItem<int>(
          value: 1,
          groupValue: 0,
          title: 'Custom Size & Padding',
          subtitle: 'Radio is small (18) and spaced (20)',
          radioSize: 18,
          spacing: 20,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          onChanged: (_) {},
        ),
        const SizedBox(height: DCSpacing.md),
        DCRadioItem<int>(
          value: 1,
          groupValue: 0,
          title: 'Custom Text Styles',
          titleStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: DCColors.primary,
          ),
          subtitle: 'Italic gray subtitle',
          subtitleStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            color: DCColors.gray500,
          ),
          onChanged: (_) {},
        ),
      ],
    );
  }
}
