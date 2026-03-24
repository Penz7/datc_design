import 'package:intl/intl.dart';

extension DoubleMoneyExtension on double {
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
}
