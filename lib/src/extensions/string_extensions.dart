import 'package:intl/intl.dart';

extension StringMoneyExtension on String {
  /// Formats a string as currency.
  /// 
  /// [symbol] is the currency symbol (e.g., "$", "đ", "€").
  /// [isLeftSymbol] determines if the symbol is on the left (prefix) or right (suffix).
  /// [decimalDigits] number of digits after decimal point.
  /// [locale] determines group separators (e.g., "vi_VN" uses dots for thousands).
  /// 
  /// Returns the formatted string, or the original string if parsing fails.
  String formatMoney({
    String symbol = 'đ',
    bool isLeftSymbol = false,
    int decimalDigits = 0,
    String locale = 'vi_VN',
  }) {
    if (isEmpty) return this;

    try {
      // Clean the string from non-numeric characters except decimals
      final double? value = double.tryParse(replaceAll(RegExp(r'[^0-9.]'), ''));
      if (value == null) return this;

      final formatter = NumberFormat.currency(
        locale: locale,
        symbol: symbol,
        decimalDigits: decimalDigits,
        customPattern: isLeftSymbol ? '¤ #,###' : '#,### ¤',
      );

      return formatter.format(value).trim();
    } catch (e) {
      return this;
    }
  }
}
