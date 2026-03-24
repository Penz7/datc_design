import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCCheckboxDemo extends StatefulWidget {
  const DCCheckboxDemo({super.key});

  @override
  State<DCCheckboxDemo> createState() => _DCCheckboxDemoState();
}

class _DCCheckboxDemoState extends State<DCCheckboxDemo> {
  bool _check1 = true;
  bool _check2 = false;
  bool _check3 = false;

  bool _listA = true;
  bool _listB = false;
  bool _listC = true;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCCheckbox',
      children: [
        const SectionTitle('DCCheckboxItem (standalone)'),
        DCCheckboxItem(
          value: _check1,
          title: 'Notifications',
          subtitle: 'Receive push notifications',
          onChanged: (val) => setState(() => _check1 = val!),
        ),
        DCCheckboxItem(
          value: _check2,
          title: 'Dark Mode',
          subtitle: 'Enable dark theme',
          onChanged: (val) => setState(() => _check2 = val!),
        ),
        DCCheckboxItem(
          value: _check3,
          title: 'Analytics',
          subtitle: 'Share anonymous usage data',
          onChanged: (val) => setState(() => _check3 = val!),
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('DCListCheckbox (grouped)'),
        DCListCheckbox(
          items: [
            DCCheckboxOption(
              value: _listA,
              title: 'Email',
              subtitle: 'Receive email updates',
              onChanged: (val) => setState(() => _listA = val!),
            ),
            DCCheckboxOption(
              value: _listB,
              title: 'SMS',
              subtitle: 'Receive SMS alerts',
              onChanged: (val) => setState(() => _listB = val!),
            ),
            DCCheckboxOption(
              value: _listC,
              title: 'In-App',
              subtitle: 'In-app notifications',
              onChanged: (val) => setState(() => _listC = val!),
            ),
          ],
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Custom Icons (Icons/Images)'),
        DCCheckboxItem(
          value: _check1,
          title: 'Custom Icon Pair',
          subtitle: 'Uses Check vs Square icons',
          activeIcon: const Icon(
            Icons.check_box,
            color: DCColors.secondary,
            size: 24,
          ),
          inactiveIcon: const Icon(
            Icons.check_box_outline_blank,
            color: DCColors.gray300,
            size: 24,
          ),
          onChanged: (val) => setState(() => _check1 = val!),
        ),
        const SizedBox(height: DCSpacing.xl),
        const SectionTitle('Customizable Styles'),
        DCCheckboxItem(
          value: _check2,
          title: 'Custom Size & Style',
          checkboxSize: 30,
          spacing: 20,
          onChanged: (val) => setState(() => _check2 = val!),
          titleStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: DCColors.primary,
          ),
        ),
      ],
    );
  }
}
