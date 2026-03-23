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
      ],
    );
  }
}
