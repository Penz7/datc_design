import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  // ─────────────────────────────────────────────
  // MONEY
  // ─────────────────────────────────────────────

  /// Formats a double as currency.
  String formatMoney({
    String symbol = 'đ',
    bool isLeftSymbol = false,
    int decimalDigits = 0,
    String locale = 'vi_VN',
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: isLeftSymbol ? '¤ #,###' : '#,### ¤',
    );
    return formatter.format(this).trim();
  }

  // ─────────────────────────────────────────────
  // ROUNDING
  // ─────────────────────────────────────────────

  /// Rounds to [places] decimal places.
  /// e.g. 3.14159.roundTo(2) → 3.14
  double roundTo(int places) {
    final double mod = 1.0;
    double factor = mod;
    for (int i = 0; i < places; i++) {
      factor *= 10;
    }
    return (this * factor).round() / factor;
  }

  /// Returns a formatted string with [places] decimal digits.
  /// e.g. 3.1.toFixed(2) → "3.10"
  String toFixed(int places) => toStringAsFixed(places);

  /// Removes trailing zeros from a decimal string.
  /// e.g. 3.10 → "3.1", 4.00 → "4"
  String get removeTrailingZeros {
    final String s = toString();
    if (!s.contains('.')) return s;
    String trimmed = s.replaceAll(RegExp(r'0+$'), '');
    if (trimmed.endsWith('.')) {
      trimmed = trimmed.substring(0, trimmed.length - 1);
    }
    return trimmed;
  }

  // ─────────────────────────────────────────────
  // PERCENTAGE
  // ─────────────────────────────────────────────

  /// Converts this double to a percentage string.
  /// e.g. 0.856.toPercent() → "85.6%"
  String toPercent({int decimalDigits = 1}) {
    return '${(this * 100).toStringAsFixed(decimalDigits)}%';
  }

  /// Formats as a percentage string where this is already a percentage value.
  /// e.g. 85.6.asPercent() → "85.6%"
  String asPercent({int decimalDigits = 1}) {
    return '${toStringAsFixed(decimalDigits)}%';
  }

  // ─────────────────────────────────────────────
  // COMPACT FORMAT
  // ─────────────────────────────────────────────

  /// Formats a large number with compact notation.
  /// e.g. 1500.0 → "1.5K", 2500000.0 → "2.5M"
  String get compact {
    if (abs() >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(1)}B';
    } else if (abs() >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (abs() >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return removeTrailingZeros;
  }

  /// Formats this double with thousands separators and decimal places.
  /// e.g. 1234567.89.formatNumber(decimalDigits: 2) → "1.234.567,89"
  String formatNumber({int decimalDigits = 0, String locale = 'vi_VN'}) {
    return NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: decimalDigits,
    ).format(this);
  }

  // ─────────────────────────────────────────────
  // SPACING HELPERS (for Flutter)
  // ─────────────────────────────────────────────

  /// Returns a vertical [SizedBox] with this height.
  SizedBox get verticalSpace => SizedBox(height: this);

  /// Returns a horizontal [SizedBox] with this width.
  SizedBox get horizontalSpace => SizedBox(width: this);

  /// Returns a [BorderRadius.circular] with this radius.
  BorderRadius get circularRadius => BorderRadius.circular(this);

  /// Returns symmetric [EdgeInsets] with this value.
  EdgeInsets get allInsets => EdgeInsets.all(this);

  // ─────────────────────────────────────────────
  // BOOLEAN / RANGE
  // ─────────────────────────────────────────────

  /// Returns `true` if this value is between [min] and [max] (inclusive).
  bool isBetween(double min, double max) => this >= min && this <= max;

  /// Clamps this value to the range [min, max].
  double clampRange(double min, double max) => clamp(min, max).toDouble();
}
