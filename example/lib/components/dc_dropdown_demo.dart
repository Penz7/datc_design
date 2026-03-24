import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DCDropdownDemo extends StatefulWidget {
  const DCDropdownDemo({super.key});

  @override
  State<DCDropdownDemo> createState() => _DCDropdownDemoState();
}

class _DCDropdownDemoState extends State<DCDropdownDemo> {
  String? _selectedValue;
  final List<String> _options = ['Apple', 'Banana', 'Cherry', 'Dragonfruit'];

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DCDropdown',
      children: [
        const SectionTitle('Standard Dropdown (Animated)'),
        DCDropdown<String>(
          items: _options,
          value: _selectedValue,
          onChanged: (val) => setState(() => _selectedValue = val),
          hintText: 'Select a fruit',
          labelText: 'Choose Fruit',
        ),
        const SizedBox(height: DCSpacing.md),
        DCText.medium('Selected: ${_selectedValue ?? "None"}'),

        const SectionTitle('Custom Menu Builder (Custom Overlay)'),
        DCDropdown<String>(
          items: _options,
          value: _selectedValue,
          onChanged: (val) => setState(() => _selectedValue = val),
          hintText: 'Custom Menu Style',
          customMenuBuilder: (context, items, value, onSelect) {
            return Container(
              decoration: BoxDecoration(
                color: DCColors.gray900,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: DCColors.primary, width: 2),
              ),
              child: GridView.count(
                padding: const EdgeInsets.all(DCSpacing.sm),
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 3,
                children: items.map((item) {
                  final isSelected = item == value;
                  return InkWell(
                    onTap: () => onSelect(item),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? DCColors.primary : DCColors.gray800,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DCText(
                        item,
                        color: Colors.white,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),

        const SectionTitle('Custom Holder & Menu'),
        DCDropdown<String>(
          items: _options,
          value: _selectedValue,
          onChanged: (val) => setState(() => _selectedValue = val),
          customHolder: (context, value, isOpen) {
            return Container(
              padding: const EdgeInsets.all(DCSpacing.md),
              decoration: BoxDecoration(
                color: isOpen ? DCColors.primary : DCColors.gray100,
                borderRadius: BorderRadius.circular(30),
                boxShadow: isOpen ? [BoxShadow(color: DCColors.primary.withValues(alpha: 0.3), blurRadius: 8)] : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DCText.medium(
                    value ?? 'Choose Fruit',
                    color: isOpen ? Colors.white : DCColors.textPrimary,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: isOpen ? Colors.white : DCColors.primary,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
