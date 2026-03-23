import 'package:flutter/material.dart';

/// DC Color Extensions - withOpacity replacement
extension DCColorExtension on Color {
  /// opacityColor - withOpacity replacement using withAlpha()
  Color opacityColor(double opacity) {
    final newAlpha = (a * opacity).round().clamp(0, 255);
    return withAlpha(newAlpha);
  }

  /// opacity convenience method
  Color opacity(double opacity) => opacityColor(opacity);
}
