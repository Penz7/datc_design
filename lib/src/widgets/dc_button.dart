import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../constants/font_sizes.dart';

/// DC Custom Button
class DCButton extends StatelessWidget {
  const DCButton._({
    super.key,
    required this.onPressed,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    required this.variant,
    this.size = DCButtonSize.medium,
    this.isLoading = false,
    this.fullWidth = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.borderSide,
    this.elevation,
    this.textStyle,
    this.loadingWidget,
    this.loadingColor,
  });

  /// Factory for a filled button with brand colors.
  factory DCButton.fill({
    Key? key,
    required VoidCallback onPressed,
    required String label,
    Widget? leadingIcon,
    Widget? trailingIcon,
    DCButtonSize size = DCButtonSize.medium,
    bool isLoading = false,
    bool fullWidth = false,
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Widget? loadingWidget,
    Color? loadingColor,
  }) {
    return DCButton._(
      key: key,
      onPressed: onPressed,
      label: label,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      variant: DCButtonVariant.filled,
      size: size,
      isLoading: isLoading,
      fullWidth: fullWidth,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius != null
          ? BorderRadius.circular(borderRadius)
          : null,
      padding: padding,
      elevation: elevation,
      loadingWidget: loadingWidget,
      loadingColor: loadingColor,
    );
  }

  /// Factory for an outlined button.
  factory DCButton.outline({
    Key? key,
    required VoidCallback onPressed,
    required String label,
    Widget? leadingIcon,
    Widget? trailingIcon,
    DCButtonSize size = DCButtonSize.medium,
    bool isLoading = false,
    bool fullWidth = false,
    Color? borderColor,
    Color? foregroundColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    Widget? loadingWidget,
    Color? loadingColor,
  }) {
    return DCButton._(
      key: key,
      onPressed: onPressed,
      label: label,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      variant: DCButtonVariant.outlined,
      size: size,
      isLoading: isLoading,
      fullWidth: fullWidth,
      borderSide: borderColor != null
          ? BorderSide(color: borderColor, width: 1.5)
          : null,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius != null
          ? BorderRadius.circular(borderRadius)
          : null,
      padding: padding,
      loadingWidget: loadingWidget,
      loadingColor: loadingColor,
    );
  }

  /// Factory for a highly customizable button.
  factory DCButton.custom({
    Key? key,
    required VoidCallback onPressed,
    required String label,
    Widget? leadingIcon,
    Widget? trailingIcon,
    DCButtonSize size = DCButtonSize.medium,
    bool isLoading = false,
    bool fullWidth = false,
    Color? backgroundColor,
    Color? foregroundColor,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? elevation,
    TextStyle? textStyle,
    Widget? loadingWidget,
    Color? loadingColor,
  }) {
    return DCButton._(
      key: key,
      onPressed: onPressed,
      label: label,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      variant: DCButtonVariant.custom,
      size: size,
      isLoading: isLoading,
      fullWidth: fullWidth,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderSide: borderSide,
      borderRadius: borderRadius,
      padding: padding,
      elevation: elevation,
      textStyle: textStyle,
      loadingWidget: loadingWidget,
      loadingColor: loadingColor,
    );
  }

  final VoidCallback onPressed;
  final String label;

  /// Icon or widget to display before the label.
  final Widget? leadingIcon;

  /// Icon or widget to display after the label.
  final Widget? trailingIcon;

  final DCButtonVariant variant;
  final DCButtonSize size;
  final bool isLoading;
  final bool fullWidth;

  /// Custom background color.
  final Color? backgroundColor;

  /// Custom text and icon color.
  final Color? foregroundColor;

  /// Custom border radius.
  final BorderRadius? borderRadius;

  /// Custom internal padding.
  final EdgeInsetsGeometry? padding;

  /// Custom border side.
  final BorderSide? borderSide;

  /// Custom elevation.
  final double? elevation;

  /// Custom text style for the label.
  final TextStyle? textStyle;

  /// Custom widget to show during loading state.
  final Widget? loadingWidget;

  /// Custom color for the default loading indicator.
  final Color? loadingColor;

  @override
  Widget build(BuildContext context) {
    final bool isFilled = variant == DCButtonVariant.filled;
    final bool isOutline = variant == DCButtonVariant.outlined;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ?? _getPadding(),
          backgroundColor: _getBackgroundColor(),
          foregroundColor: _getForegroundColor(),
          side: borderSide ?? _getSide(),
          elevation: elevation ?? (isFilled ? 2 : 0),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(DCSpacing.md),
          ),
          shadowColor: isOutline || variant == DCButtonVariant.text
              ? Colors.transparent
              : null,
        ),
        child: _buildChild(context),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    switch (variant) {
      case DCButtonVariant.filled:
        return DCColors.primary;
      case DCButtonVariant.outlined:
      case DCButtonVariant.text:
      case DCButtonVariant.custom:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor() {
    if (foregroundColor != null) return foregroundColor!;
    switch (variant) {
      case DCButtonVariant.filled:
        return Colors.white;
      case DCButtonVariant.outlined:
        return DCColors.primary;
      case DCButtonVariant.text:
      case DCButtonVariant.custom:
        return DCColors.textPrimary;
    }
  }

  BorderSide? _getSide() {
    if (variant == DCButtonVariant.outlined) {
      return const BorderSide(color: DCColors.primary, width: 1.5);
    }
    return null;
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case DCButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: DCSpacing.sm,
          vertical: DCSpacing.xs,
        );
      case DCButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: DCSpacing.md,
          vertical: DCSpacing.sm,
        );
      case DCButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: DCSpacing.lg,
          vertical: DCSpacing.md,
        );
    }
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      if (loadingWidget != null) return loadingWidget!;
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: loadingColor ?? _getForegroundColor(),
        ),
      );
    }

    final TextStyle defaultStyle = TextStyle(
      fontSize: _getFontSize(),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );

    final text = Text(label, style: textStyle ?? defaultStyle);

    if (leadingIcon == null && trailingIcon == null) return text;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          _wrapIcon(leadingIcon!),
          const SizedBox(width: DCSpacing.xs),
        ],
        text,
        if (trailingIcon != null) ...[
          const SizedBox(width: DCSpacing.xs),
          _wrapIcon(trailingIcon!),
        ],
      ],
    );
  }

  Widget _wrapIcon(Widget icon) {
    if (icon is Icon) {
      return Icon(
        icon.icon,
        size: icon.size ?? _getIconSize(),
        color: icon.color ?? _getForegroundColor(),
      );
    }
    return SizedBox(width: _getIconSize(), height: _getIconSize(), child: icon);
  }

  double _getFontSize() {
    switch (size) {
      case DCButtonSize.small:
        return DCFontSize.tiny;
      case DCButtonSize.medium:
        return DCFontSize.normal;
      case DCButtonSize.large:
        return DCFontSize.md;
    }
  }

  double _getIconSize() {
    switch (size) {
      case DCButtonSize.small:
        return 16;
      case DCButtonSize.medium:
        return 20;
      case DCButtonSize.large:
        return 24;
    }
  }
}

enum DCButtonVariant { filled, outlined, text, custom }

enum DCButtonSize { small, medium, large }
