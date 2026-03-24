import 'package:flutter/material.dart';
import '../constants/index.dart';

/// DCSwitch — A fully customizable toggle switch for the DATC Design System.
///
/// Supports:
/// - Custom track/thumb colors (active & inactive states)
/// - Size scaling
/// - Leading/trailing labels with custom text styles
/// - Custom padding
/// - Disabled state
/// - Optional onLabel / offLabel text drawn inside the track
///
/// Usage:
/// ```dart
/// // Basic
/// DCSwitch(
///   value: _isOn,
///   onChanged: (v) => setState(() => _isOn = v),
/// )
///
/// // With labels
/// DCSwitch.labeled(
///   value: _isOn,
///   onChanged: (v) => setState(() => _isOn = v),
///   label: 'Notifications',
/// )
///
/// // Compact custom
/// DCSwitch(
///   value: _isOn,
///   onChanged: (v) => setState(() => _isOn = v),
///   activeTrackColor: DCColors.secondary,
///   size: DCSwitchSize.small,
///   onLabel: 'ON',
///   offLabel: 'OFF',
/// )
/// ```
class DCSwitch extends StatelessWidget {
  /// Default constructor — standalone switch.
  const DCSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = DCSwitchSize.medium,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.activeTrackBorderColor,
    this.inactiveTrackBorderColor,
    this.onLabel,
    this.offLabel,
    this.onLabelStyle,
    this.offLabelStyle,
    this.padding,
    this.isDisabled = false,
  }) : label = null,
       labelStyle = null,
       labelPosition = DCSwitchLabelPosition.trailing;

  /// Named constructor — switch with a label (leading or trailing).
  const DCSwitch.labeled({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.labelStyle,
    this.labelPosition = DCSwitchLabelPosition.trailing,
    this.size = DCSwitchSize.medium,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.activeTrackBorderColor,
    this.inactiveTrackBorderColor,
    this.onLabel,
    this.offLabel,
    this.onLabelStyle,
    this.offLabelStyle,
    this.padding,
    this.isDisabled = false,
  });

  // ── Core ──────────────────────────────────────────────────────────────────

  /// The current value of the switch.
  final bool value;

  /// Callback when the switch is toggled.
  final ValueChanged<bool>? onChanged;

  // ── External Label ────────────────────────────────────────────────────────

  /// Optional label text displayed next to the switch.
  final String? label;

  /// Style for the external label text.
  final TextStyle? labelStyle;

  /// Position of the external label relative to the switch.
  final DCSwitchLabelPosition labelPosition;

  // ── Size & Layout ─────────────────────────────────────────────────────────

  /// Controls the overall size of the switch.
  final DCSwitchSize size;

  /// Custom padding around the entire widget.
  final EdgeInsetsGeometry? padding;

  // ── Colors ────────────────────────────────────────────────────────────────

  /// Track color when [value] is `true`. Defaults to [DCColors.primary].
  final Color? activeTrackColor;

  /// Track color when [value] is `false`. Defaults to [DCColors.gray300].
  final Color? inactiveTrackColor;

  /// Thumb color when [value] is `true`. Defaults to white.
  final Color? activeThumbColor;

  /// Thumb color when [value] is `false`. Defaults to white.
  final Color? inactiveThumbColor;

  /// Track border color when active.
  final Color? activeTrackBorderColor;

  /// Track border color when inactive.
  final Color? inactiveTrackBorderColor;

  // ── Inner Track Labels ────────────────────────────────────────────────────

  /// Text drawn inside the track when [value] is `true` (e.g., "ON").
  final String? onLabel;

  /// Text drawn inside the track when [value] is `false` (e.g., "OFF").
  final String? offLabel;

  /// Style for [onLabel].
  final TextStyle? onLabelStyle;

  /// Style for [offLabel].
  final TextStyle? offLabelStyle;

  // ── State ─────────────────────────────────────────────────────────────────

  /// When true, the switch is non-interactive and visually dimmed.
  final bool isDisabled;

  // ── Computed Dimensions ───────────────────────────────────────────────────

  double get _trackWidth {
    switch (size) {
      case DCSwitchSize.small:
        return 36;
      case DCSwitchSize.medium:
        return 48;
      case DCSwitchSize.large:
        return 60;
    }
  }

  double get _trackHeight {
    switch (size) {
      case DCSwitchSize.small:
        return 20;
      case DCSwitchSize.medium:
        return 26;
      case DCSwitchSize.large:
        return 32;
    }
  }

  double get _thumbSize {
    switch (size) {
      case DCSwitchSize.small:
        return 14;
      case DCSwitchSize.medium:
        return 20;
      case DCSwitchSize.large:
        return 26;
    }
  }

  double get _thumbPadding => (_trackHeight - _thumbSize) / 2;

  double get _labelFontSize {
    switch (size) {
      case DCSwitchSize.small:
        return DCFontSize.xs;
      case DCSwitchSize.medium:
        return DCFontSize.sm;
      case DCSwitchSize.large:
        return DCFontSize.tiny;
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final effectiveOnChanged = isDisabled ? null : onChanged;
    final bool isActive = value && !isDisabled;

    final Color trackColor = isActive
        ? (activeTrackColor ?? DCColors.primary)
        : (inactiveTrackColor ?? DCColors.gray300);
    final Color thumbColor = isActive
        ? (activeThumbColor ?? Colors.white)
        : (inactiveThumbColor ?? Colors.white);

    final Color? borderColor = isActive
        ? activeTrackBorderColor
        : inactiveTrackBorderColor;

    Widget switchWidget = Opacity(
      opacity: isDisabled ? 0.4 : 1.0,
      child: GestureDetector(
        onTap: effectiveOnChanged != null
            ? () => effectiveOnChanged(!value)
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: _trackWidth,
          height: _trackHeight,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(_trackHeight / 2),
            border: borderColor != null
                ? Border.all(color: borderColor, width: 1.5)
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Inner track label
              if (onLabel != null || offLabel != null)
                _buildTrackLabel(isActive),
              // Thumb
              AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(_thumbPadding),
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: BoxDecoration(
                      color: thumbColor,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (label == null) {
      return padding != null
          ? Padding(padding: padding!, child: switchWidget)
          : switchWidget;
    }

    final labelWidget = Text(
      label!,
      style:
          labelStyle ??
          TextStyle(
            fontSize: DCFontSize.normal,
            fontWeight: FontWeight.w500,
            color: isDisabled ? DCColors.gray400 : DCColors.textPrimary,
          ),
    );

    final children = labelPosition == DCSwitchLabelPosition.trailing
        ? [switchWidget, const SizedBox(width: DCSpacing.sm), labelWidget]
        : [labelWidget, const SizedBox(width: DCSpacing.sm), switchWidget];

    final row = GestureDetector(
      onTap: effectiveOnChanged != null
          ? () => effectiveOnChanged(!value)
          : null,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );

    return padding != null ? Padding(padding: padding!, child: row) : row;
  }

  Widget _buildTrackLabel(bool isActive) {
    final currentLabel = isActive ? onLabel : offLabel;
    final currentStyle = isActive ? onLabelStyle : offLabelStyle;
    if (currentLabel == null || currentLabel.isEmpty) return const SizedBox();

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: 1.0,
      child: Padding(
        padding: EdgeInsets.only(
          left: isActive ? 0 : _thumbSize + _thumbPadding * 2,
          right: isActive ? _thumbSize + _thumbPadding * 2 : 0,
        ),
        child: Text(
          currentLabel,
          style:
              currentStyle ??
              TextStyle(
                fontSize: _labelFontSize,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.0,
              ),
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}

/// Size variants for [DCSwitch].
enum DCSwitchSize { small, medium, large }

/// Label position relative to the switch track.
enum DCSwitchLabelPosition { leading, trailing }
