import 'package:flutter/material.dart';
import '../constants/index.dart';
import 'dc_text.dart';

/// DC Custom Radio Widget
class DCRadio<T> extends StatelessWidget {
  const DCRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.fillColor,
    this.toggleable = false,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? activeColor;
  final Color? fillColor;
  final bool toggleable;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Radio<T>(
      value: value,
      // ignore: deprecated_member_use
      groupValue: groupValue,
      // ignore: deprecated_member_use
      onChanged: onChanged,
      activeColor: activeColor ?? DCColors.primary,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return activeColor ?? DCColors.primary;
        }
        return fillColor ?? DCColors.gray400;
      }),
      toggleable: toggleable,
    );
  }
}

/// DC Radio Item with Leading/Trailing support
class DCRadioItem<T> extends StatelessWidget {
  const DCRadioItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.activeColor,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.padding,
    this.borderRadius,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String title;
  final String? subtitle;
  final Color? activeColor;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onChanged != null ? () => onChanged!(value) : null,
        borderRadius: borderRadius ?? BorderRadius.circular(DCSpacing.sm),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(DCSpacing.md),
          child: Row(
            children: [
              if (controlAffinity == ListTileControlAffinity.leading) ...[
                DCRadio<T>(
                  value: value,
                  groupValue: groupValue,
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
                      color: isSelected
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
                DCRadio<T>(
                  value: value,
                  groupValue: groupValue,
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

/// A group of Radio items (List view)
class DCListRadio<T> extends StatelessWidget {
  const DCListRadio({
    super.key,
    required this.items,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.controlAffinity = ListTileControlAffinity.leading,
  });

  final List<DCRadioOption<T>> items;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Color? activeColor;
  final ListTileControlAffinity controlAffinity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items.map((option) {
        return DCRadioItem<T>(
          value: option.value,
          groupValue: groupValue,
          onChanged: onChanged,
          title: option.title,
          subtitle: option.subtitle,
          activeColor: activeColor,
          controlAffinity: controlAffinity,
        );
      }).toList(),
    );
  }
}

class DCRadioOption<T> {
  final T value;
  final String title;
  final String? subtitle;

  DCRadioOption({required this.value, required this.title, this.subtitle});
}
