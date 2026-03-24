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
    this.size,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final Color? fillColor;
  final bool tristate;

  /// Diameter/Square size of the checkbox.
  final double? size;

  @override
  Widget build(BuildContext context) {
    Widget checkbox = Checkbox(
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
      materialTapTargetSize: size != null
          ? MaterialTapTargetSize.shrinkWrap
          : null,
      visualDensity: size != null ? VisualDensity.compact : null,
      tristate: tristate,
    );

    if (size != null) {
      checkbox = SizedBox(
        width: size,
        height: size,
        child: Transform.scale(
          scale: size! / 24.0, // Default Checkbox size is approx 24
          child: checkbox,
        ),
      );
    }

    return checkbox;
  }
}

/// A custom checkbox widget that allows using labels, images, or SVGs
/// instead of the standard checkbox.
class DCCheckboxCustom extends StatelessWidget {
  const DCCheckboxCustom({
    super.key,
    required this.value,
    this.onChanged,
    required this.activeIcon,
    required this.inactiveIcon,
    this.size,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;

  /// Widget to display when selected (value is true).
  final Widget activeIcon;

  /// Widget to display when not selected (value is false or null).
  final Widget inactiveIcon;

  /// Optional fixed size for the checkbox icon wrapper.
  final double? size;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == true;

    return InkResponse(
      onTap: onChanged != null ? () => onChanged!(!isSelected) : null,
      child: SizedBox(
        width: size,
        height: size,
        child: isSelected ? activeIcon : inactiveIcon,
      ),
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
    this.titleStyle,
    this.subtitleStyle,
    this.checkboxSize,
    this.spacing = DCSpacing.sm,
    this.activeIcon,
    this.inactiveIcon,
  }) : assert(
         (activeIcon != null && inactiveIcon != null) ||
             (activeIcon == null && inactiveIcon == null),
         'Both activeIcon and inactiveIcon must be provided for a custom checkbox item.',
       );

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final String? subtitle;
  final Color? activeColor;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  /// Custom text style for the title.
  final TextStyle? titleStyle;

  /// Custom text style for the subtitle.
  final TextStyle? subtitleStyle;

  /// Custom size for the checkbox.
  final double? checkboxSize;

  /// Spacing between the checkbox and the text.
  final double spacing;

  /// Optional custom icon for active state.
  final Widget? activeIcon;

  /// Optional custom icon for inactive state.
  final Widget? inactiveIcon;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == true;

    Widget buildCheckbox({bool inheritOnChanged = false}) {
      if (activeIcon != null && inactiveIcon != null) {
        return DCCheckboxCustom(
          value: value,
          onChanged: inheritOnChanged ? onChanged : null,
          activeIcon: activeIcon!,
          inactiveIcon: inactiveIcon!,
          size: checkboxSize,
        );
      }
      return DCCheckbox(
        value: value,
        onChanged: inheritOnChanged ? onChanged : null,
        activeColor: activeColor,
        size: checkboxSize,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onChanged != null ? () => onChanged!(!isSelected) : null,
        borderRadius: borderRadius ?? BorderRadius.circular(DCSpacing.sm),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(DCSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (controlAffinity == ListTileControlAffinity.leading) ...[
                buildCheckbox(),
                SizedBox(width: spacing),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    titleStyle != null
                        ? Text(title, style: titleStyle)
                        : DCText(
                            title,
                            fontSize: DCFontSize.normal,
                            color: isSelected
                                ? DCColors.primary
                                : DCColors.textPrimary,
                          ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      subtitleStyle != null
                          ? Text(subtitle!, style: subtitleStyle)
                          : DCText(
                              subtitle!,
                              fontSize: DCFontSize.tiny,
                              color: DCColors.textSecondary,
                            ),
                    ],
                  ],
                ),
              ),
              if (controlAffinity == ListTileControlAffinity.trailing) ...[
                SizedBox(width: spacing),
                buildCheckbox(),
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
    this.itemPadding,
    this.itemSpacing = DCSpacing.sm,
    this.checkboxSize,
    this.titleStyle,
    this.subtitleStyle,
    this.activeIcon,
    this.inactiveIcon,
  });

  final List<DCCheckboxOption> items;
  final Color? activeColor;
  final ListTileControlAffinity controlAffinity;

  /// Default padding for each item.
  final EdgeInsetsGeometry? itemPadding;

  /// Spacing between the checkbox and text for each item.
  final double itemSpacing;

  /// Custom size for the checkbox.
  final double? checkboxSize;

  /// Default title style for items. (item's own style takes precedence)
  final TextStyle? titleStyle;

  /// Default subtitle style for items.
  final TextStyle? subtitleStyle;

  /// Default custom icon for active state.
  final Widget? activeIcon;

  /// Default custom icon for inactive state.
  final Widget? inactiveIcon;

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
          padding: itemPadding,
          spacing: itemSpacing,
          checkboxSize: checkboxSize,
          titleStyle: option.titleStyle ?? titleStyle,
          subtitleStyle: option.subtitleStyle ?? subtitleStyle,
          activeIcon: option.activeIcon ?? activeIcon,
          inactiveIcon: option.inactiveIcon ?? inactiveIcon,
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
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? activeIcon;
  final Widget? inactiveIcon;

  DCCheckboxOption({
    required this.value,
    required this.title,
    this.subtitle,
    this.onChanged,
    this.titleStyle,
    this.subtitleStyle,
    this.activeIcon,
    this.inactiveIcon,
  });
}
