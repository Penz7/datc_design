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
      ],
    );
  }
}
