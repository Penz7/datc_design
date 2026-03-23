import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../constants/font_sizes.dart';

/// DC Custom Button
class DCButton extends StatelessWidget {
  const DCButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.variant = DCButtonVariant.filled,
    this.size = DCButtonSize.medium,
    this.isLoading = false,
    this.fullWidth = false,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData? icon;
  final DCButtonVariant variant;
  final DCButtonSize size;
  final bool isLoading;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final child = _buildChild();

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: _getPadding(),
          backgroundColor: _getBackgroundColor(),
          foregroundColor: _getForegroundColor(),
          side: _getSide(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DCSpacing.md),
          ),
          elevation: variant == DCButtonVariant.filled ? 2 : 0,
        ),
        child: child,
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case DCButtonVariant.filled:
        return DCColors.primary;
      case DCButtonVariant.outlined:
      case DCButtonVariant.text:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case DCButtonVariant.filled:
        return Colors.white;
      case DCButtonVariant.outlined:
        return DCColors.primary;
      case DCButtonVariant.text:
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

  Widget _buildChild() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    }

    final text = Text(
      label,
      style: TextStyle(
        fontSize: _getFontSize(),
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: Colors.white,
      ),
    );

    if (icon == null) return text;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: _getIconSize()),
        const SizedBox(width: DCSpacing.xs),
        text,
      ],
    );
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

enum DCButtonVariant { filled, outlined, text }

enum DCButtonSize { small, medium, large }
