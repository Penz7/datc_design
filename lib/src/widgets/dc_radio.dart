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
    this.size,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? activeColor;
  final Color? fillColor;
  final bool toggleable;

  /// Diameter size of the radio button.
  final double? size;

  @override
  Widget build(BuildContext context) {
    Widget radio = Radio<T>(
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
      visualDensity: size != null ? VisualDensity.compact : null,
      materialTapTargetSize: size != null
          ? MaterialTapTargetSize.shrinkWrap
          : null,
    );

    if (size != null) {
      radio = SizedBox(
        width: size,
        height: size,
        child: Transform.scale(
          scale: size! / 24.0, // Radio default size is approx 24
          child: radio,
        ),
      );
    }

    return radio;
  }
}

/// A custom radio widget that allows using images or SVGs instead of the standard radio button.
class DCRadioCustom<T> extends StatelessWidget {
  const DCRadioCustom({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.activeIcon,
    required this.inactiveIcon,
    this.size,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  /// The widget to display when selected.
  final Widget activeIcon;

  /// The widget to display when not selected.
  final Widget inactiveIcon;

  /// Optional size for the radio icons.
  final double? size;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return InkResponse(
      onTap: onChanged != null ? () => onChanged!(value) : null,
      child: SizedBox(
        width: size,
        height: size,
        child: isSelected ? activeIcon : inactiveIcon,
      ),
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
    this.titleStyle,
    this.subtitleStyle,
    this.radioSize,
    this.spacing = DCSpacing.sm,
    this.activeIcon,
    this.inactiveIcon,
  }) : assert(
         (activeIcon != null && inactiveIcon != null) ||
             (activeIcon == null && inactiveIcon == null),
         'Both activeIcon and inactiveIcon must be provided for a custom radio item.',
       );

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
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

  /// Custom size for the radio button.
  final double? radioSize;

  /// Spacing between the radio button and the text.
  final double spacing;

  /// Optional custom icon for active state.
  final Widget? activeIcon;

  /// Optional custom icon for inactive state.
  final Widget? inactiveIcon;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    Widget buildRadio({bool inheritOnChanged = false}) {
      if (activeIcon != null && inactiveIcon != null) {
        return DCRadioCustom<T>(
          value: value,
          groupValue: groupValue,
          onChanged: inheritOnChanged ? onChanged : null,
          activeIcon: activeIcon!,
          inactiveIcon: inactiveIcon!,
          size: radioSize,
        );
      }
      return DCRadio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: inheritOnChanged ? onChanged : null,
        activeColor: activeColor,
        size: radioSize,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onChanged != null ? () => onChanged!(value) : null,
        borderRadius: borderRadius ?? BorderRadius.circular(DCSpacing.sm),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(DCSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (controlAffinity == ListTileControlAffinity.leading) ...[
                buildRadio(),
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
                buildRadio(),
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
    this.itemPadding,
    this.itemSpacing = DCSpacing.sm,
    this.radioSize,
    this.titleStyle,
    this.subtitleStyle,
    this.activeIcon,
    this.inactiveIcon,
  });

  final List<DCRadioOption<T>> items;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Color? activeColor;
  final ListTileControlAffinity controlAffinity;

  /// Default padding for each item.
  final EdgeInsetsGeometry? itemPadding;

  /// Spacing between the radio and text for each item.
  final double itemSpacing;

  /// Custom size for the radio button.
  final double? radioSize;

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
        return DCRadioItem<T>(
          value: option.value,
          groupValue: groupValue,
          onChanged: onChanged,
          title: option.title,
          subtitle: option.subtitle,
          activeColor: activeColor,
          controlAffinity: controlAffinity,
          padding: itemPadding,
          spacing: itemSpacing,
          radioSize: radioSize,
          titleStyle: option.titleStyle ?? titleStyle,
          subtitleStyle: option.subtitleStyle ?? subtitleStyle,
          activeIcon: option.activeIcon ?? activeIcon,
          inactiveIcon: option.inactiveIcon ?? inactiveIcon,
        );
      }).toList(),
    );
  }
}

class DCRadioOption<T> {
  final T value;
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? activeIcon;
  final Widget? inactiveIcon;

  DCRadioOption({
    required this.value,
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.activeIcon,
    this.inactiveIcon,
  });
}
