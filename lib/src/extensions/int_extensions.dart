import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension IntExtensions on int {
  // ─────────────────────────────────────────────
  // MONEY
  // ─────────────────────────────────────────────

  /// Formats an int as currency.
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
  // DURATION HELPERS
  // ─────────────────────────────────────────────

  /// Converts this int (in milliseconds) to a [Duration].
  Duration get ms => Duration(milliseconds: this);

  /// Converts this int (in seconds) to a [Duration].
  Duration get seconds => Duration(seconds: this);

  /// Converts this int (in minutes) to a [Duration].
  Duration get minutes => Duration(minutes: this);

  /// Converts this int (in hours) to a [Duration].
  Duration get hours => Duration(hours: this);

  /// Converts this int (in days) to a [Duration].
  Duration get days => Duration(days: this);

  // ─────────────────────────────────────────────
  // TIME FORMATTING
  // ─────────────────────────────────────────────

  /// Formats this int (in seconds) as "mm:ss".
  /// e.g. 125 → "02:05"
  String get toTimeMMSS {
    final int m = this ~/ 60;
    final int s = this % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  /// Formats this int (in seconds) as "HH:mm:ss".
  /// e.g. 3661 → "01:01:01"
  String get toTimeHHMMSS {
    final int h = this ~/ 3600;
    final int m = (this % 3600) ~/ 60;
    final int s = this % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  // ─────────────────────────────────────────────
  // PADDING / FORMAT
  // ─────────────────────────────────────────────

  /// Pads this int with leading zeros to a given [width].
  /// e.g. 5.padLeft(3) → "005"
  String padWithZeros(int width) => toString().padLeft(width, '0');

  /// Formats a large number with compact notation.
  /// e.g. 1200 → "1.2K", 1500000 → "1.5M"
  String get compact {
    if (abs() >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(1)}B';
    } else if (abs() >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (abs() >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toString();
  }

  /// Formats this int with thousands separators.
  /// e.g. 1234567 → "1.234.567" (vi_VN) or "1,234,567" (en_US)
  String formatNumber({String locale = 'vi_VN'}) {
    return NumberFormat('#,###', locale).format(this);
  }

  // ─────────────────────────────────────────────
  // SPACING HELPERS (for Flutter)
  // ─────────────────────────────────────────────

  /// Returns a vertical [SizedBox] with this height.
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  /// Returns a horizontal [SizedBox] with this width.
  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  // ─────────────────────────────────────────────
  // BOOLEAN / RANGE
  // ─────────────────────────────────────────────

  /// Returns `true` if this value is between [min] and [max] (inclusive).
  bool isBetween(int min, int max) => this >= min && this <= max;

  /// Clamps this value to the range [min, max].
  int clampRange(int min, int max) => clamp(min, max).toInt();

  /// Returns `true` if this int is even.
  bool get isEvenNumber => this % 2 == 0;

  /// Returns `true` if this int is odd.
  bool get isOddNumber => this % 2 != 0;
}
