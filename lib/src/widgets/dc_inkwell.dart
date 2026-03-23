import 'package:flutter/material.dart';
import '../constants/index.dart';
import 'dc_text.dart';
import '../extensions/index.dart';

/// DC Custom InkWell with consistent styling
class DCInkWell extends StatelessWidget {
  const DCInkWell({
    super.key,
    required this.onTap,
    required this.label,
    this.icon,
    this.trailing,
    this.borderRadius = DCSpacing.md,
    this.padding,
    this.color,
    this.splashColor,
    this.highlightColor,
    this.elevation = 1,
  });

  final VoidCallback onTap;
  final String label;
  final IconData? icon;
  final Widget? trailing;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? splashColor;
  final Color? highlightColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.transparent,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: splashColor ?? DCColors.primary.opacityColor(0.2),
        highlightColor: highlightColor ?? DCColors.gray100,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(DCSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: DCColors.textPrimary),
                const SizedBox(width: DCSpacing.sm),
              ],
              Flexible(
                child: DCText(
                  label,
                  fontSize: DCFontSize.normal,
                  weight: FontWeight.w500,
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: DCSpacing.sm),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// DCInkWell variants
class DCInkWellVariant extends StatelessWidget {
  const DCInkWellVariant({
    super.key,
    required this.onTap,
    required this.child,
    this.borderRadius = DCSpacing.md,
    this.padding,
    this.color,
    this.splashColor,
    this.highlightColor,
  });

  final VoidCallback onTap;
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? splashColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: splashColor ?? DCColors.primary.opacityColor(0.2),
        highlightColor: highlightColor ?? DCColors.gray100,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(DCSpacing.md),
          child: child,
        ),
      ),
    );
  }
}

/// Usage example
/// ```dart
/// DCInkWell(
///   onTap: () {},
///   label: 'Tap me',
///   icon: Icons.arrow_forward,
/// )
/// ```
