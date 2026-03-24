import 'package:flutter/material.dart';
import '../../constants/index.dart';

/// DCCustomDialog - An extremely flexible dialog that allows a custom body.
///
/// Usage:
/// ```dart
/// DCCustomDialog(
///   child: Column(...),
///   backgroundColor: Colors.white,
///   borderRadius: 16,
///   padding: EdgeInsets.all(24),
/// )
/// ```
class DCCustomDialog extends StatelessWidget {
  const DCCustomDialog({
    super.key,
    required this.child,
    this.backgroundColor = DCColors.surface,
    this.borderRadius = DCSpacing.md,
    this.padding = const EdgeInsets.all(DCSpacing.md),
    this.maxWidth = 320.0,
    this.barrierDismissible = true,
  });

  /// The custom content to display inside the dialog.
  final Widget child;

  /// Background color of the dialog container.
  final Color backgroundColor;

  /// Corner radius of the dialog.
  final double borderRadius;

  /// Internal padding for the custom child.
  final EdgeInsetsGeometry padding;

  /// Maximum width of the dialog.
  final double maxWidth;

  /// Whether the dialog can be dismissed by tapping the barrier.
  final bool barrierDismissible;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: barrierDismissible,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: DCSpacing.lg,
          vertical: DCSpacing.lg,
        ),
        child: Container(
          width: maxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
