import 'package:flutter/material.dart';
import '../constants/index.dart';
import 'dc_text.dart';

/// DC Custom Checkbox Widget
class DCCheckbox extends StatelessWidget {
  const DCCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.tristate = false,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final Color? fillColor;
  final bool tristate;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? DCColors.primary,
      checkColor: checkColor ?? Colors.white,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return activeColor ?? DCColors.primary;
        }
        return fillColor ?? DCColors.gray300;
      }),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      tristate: tristate,
    );
  }
}

/// DC Checkbox Item with Leading/Trailing support
class DCCheckboxItem extends StatelessWidget {
  const DCCheckboxItem({
    super.key,
    required this.value,
    this.onChanged,
    required this.title,
    this.subtitle,
    this.activeColor,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.padding,
    this.borderRadius,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final String? subtitle;
  final Color? activeColor;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onChanged != null ? () => onChanged!(!(value ?? false)) : null,
        borderRadius: borderRadius ?? BorderRadius.circular(DCSpacing.sm),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(DCSpacing.md),
          child: Row(
            children: [
              if (controlAffinity == ListTileControlAffinity.leading) ...[
                DCCheckbox(
                  value: value,
                  onChanged: onChanged,
                  activeColor: activeColor,
                ),
                const SizedBox(width: DCSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DCText(
                      title,
                      fontSize: DCFontSize.normal,
                      color: (value ?? false)
                          ? DCColors.primary
                          : DCColors.textPrimary,
                    ),
                    if (subtitle != null)
                      DCText(
                        subtitle!,
                        fontSize: DCFontSize.tiny,
                        color: DCColors.textSecondary,
                      ),
                  ],
                ),
              ),
              if (controlAffinity == ListTileControlAffinity.trailing) ...[
                const SizedBox(width: DCSpacing.sm),
                DCCheckbox(
                  value: value,
                  onChanged: onChanged,
                  activeColor: activeColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A group of Checkbox items (List view)
class DCListCheckbox extends StatelessWidget {
  const DCListCheckbox({
    super.key,
    required this.items,
    this.activeColor,
    this.controlAffinity = ListTileControlAffinity.leading,
  });

  final List<DCCheckboxOption> items;
  final Color? activeColor;
  final ListTileControlAffinity controlAffinity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items.map((option) {
        return DCCheckboxItem(
          value: option.value,
          onChanged: option.onChanged,
          title: option.title,
          subtitle: option.subtitle,
          activeColor: activeColor,
          controlAffinity: controlAffinity,
        );
      }).toList(),
    );
  }
}

class DCCheckboxOption {
  final bool value;
  final String title;
  final String? subtitle;
  final ValueChanged<bool?>? onChanged;

  DCCheckboxOption({
    required this.value,
    required this.title,
    this.subtitle,
    this.onChanged,
  });
}
