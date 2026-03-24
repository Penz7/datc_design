import 'package:intl/intl.dart';

extension StringExtensions on String {
  // ─────────────────────────────────────────────
  // VALIDATION
  // ─────────────────────────────────────────────

  /// Returns `true` if the string is a valid email address.
  bool get isEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  /// Returns `true` if the string is a valid Vietnamese/international phone number.
  bool get isPhoneNumber {
    return RegExp(r'^\+?[0-9]{9,15}$').hasMatch(replaceAll(RegExp(r'\s'), ''));
  }

  /// Returns `true` if the string contains only numeric characters.
  bool get isNumeric => double.tryParse(this) != null;

  /// Returns `true` if the string contains only integer characters.
  bool get isInteger => int.tryParse(this) != null;

  /// Returns `true` if the string is a valid URL.
  bool get isUrl {
    return RegExp(
      r'^(https?:\/\/)?([\da-z\.\-]+)\.([a-z\.]{2,6})([\/\w\.\-]*)*\/?$',
      caseSensitive: false,
    ).hasMatch(this);
  }

  /// Returns `true` if the string is null or empty (blank).
  bool get isBlank => trim().isEmpty;

  // ─────────────────────────────────────────────
  // FORMATTING
  // ─────────────────────────────────────────────

  /// Capitalizes the first letter of the string.
  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Capitalizes the first letter of each word.
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((w) => w.capitalizeFirst).join(' ');
  }

  /// Converts the string to title case.
  String get toTitleCase => capitalizeWords;

  /// Converts camelCase or PascalCase to a space-separated string.
  /// e.g. "helloWorld" → "Hello World"
  String get fromCamelCase {
    return replaceAllMapped(
      RegExp(r'([A-Z])'),
      (m) => ' ${m.group(0)}',
    ).trim().capitalizeFirst;
  }

  /// Truncates the string to [maxLength] characters and appends [ellipsis].
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Removes all whitespace from the string.
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  // ─────────────────────────────────────────────
  // CONVERSION
  // ─────────────────────────────────────────────

  /// Parses the string to an `int`. Returns `null` if parsing fails.
  int? toIntOrNull() => int.tryParse(this);

  /// Parses the string to a `double`. Returns `null` if parsing fails.
  double? toDoubleOrNull() => double.tryParse(this);

  /// Returns `true` if the string represents a truthy value
  /// ("true", "1", "yes", "on" — case-insensitive).
  bool toBool() {
    const truthy = {'true', '1', 'yes', 'on'};
    return truthy.contains(toLowerCase());
  }

  /// Parses the string to a `DateTime`. Returns `null` if parsing fails.
  DateTime? toDateTime([String? format]) {
    try {
      if (format != null) {
        return DateFormat(format).parseStrict(this);
      }
      return DateTime.parse(this);
    } catch (_) {
      return null;
    }
  }

  // ─────────────────────────────────────────────
  // MONEY
  // ─────────────────────────────────────────────

  /// Formats a numeric string as currency.
  ///
  /// [symbol] is the currency symbol (e.g., "$", "đ", "€").
  /// [isLeftSymbol] determines if the symbol is on the left (prefix) or right (suffix).
  /// [decimalDigits] number of digits after decimal point.
  /// [locale] determines group separators (e.g., "vi_VN" uses dots for thousands).
  String formatMoney({
    String symbol = 'đ',
    bool isLeftSymbol = false,
    int decimalDigits = 0,
    String locale = 'vi_VN',
  }) {
    if (isEmpty) return this;
    try {
      final double? value = double.tryParse(replaceAll(RegExp(r'[^0-9.]'), ''));
      if (value == null) return this;
      final formatter = NumberFormat.currency(
        locale: locale,
        symbol: symbol,
        decimalDigits: decimalDigits,
        customPattern: isLeftSymbol ? '¤ #,###' : '#,### ¤',
      );
      return formatter.format(value).trim();
    } catch (_) {
      return this;
    }
  }

  // ─────────────────────────────────────────────
  // UI HELPERS
  // ─────────────────────────────────────────────

  /// Returns the initials of the string (up to 2 characters).
  /// Useful for avatar placeholders.
  /// e.g. "Nguyen Van A" → "NA" | "Flutter" → "F"
  String get initials {
    final parts = trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  /// Masks a phone number, showing only the last [visibleDigits] characters.
  /// e.g. "0901234567".maskPhone() → "***234567"
  String maskPhone({int visibleDigits = 6}) {
    if (length <= visibleDigits) return this;
    final masked = '*' * (length - visibleDigits);
    return masked + substring(length - visibleDigits);
  }

  /// Masks an email address.
  /// e.g. "example@gmail.com" → "ex*****@gmail.com"
  String get maskEmail {
    final parts = split('@');
    if (parts.length != 2) return this;
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 2) return this;
    final masked = '${name.substring(0, 2)}${'*' * (name.length - 2)}';
    return '$masked@$domain';
  }

  /// Returns the file extension from a path/URL.
  /// e.g. "/path/to/file.dart" → "dart"
  String get fileExtension {
    final dotIndex = lastIndexOf('.');
    if (dotIndex < 0 || dotIndex == length - 1) return '';
    return substring(dotIndex + 1);
  }

  /// Returns `true` if this string is an image URL/path.
  bool get isImagePath {
    const imageExtensions = {'jpg', 'jpeg', 'png', 'gif', 'webp', 'svg', 'bmp'};
    return imageExtensions.contains(fileExtension.toLowerCase());
  }
}
