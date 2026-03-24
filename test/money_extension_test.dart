import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('Money Extension Tests', () {
    test('Formats string to currency with right symbol (default)', () {
      expect('1000000'.formatMoney(), equals('1.000.000 đ'));
    });

    test('Formats string to currency with left symbol', () {
      final String symbol = '\$';
      expect('50000'.formatMoney(symbol: symbol, isLeftSymbol: true), equals('\$ 50.000'));
    });

    test('Formats integer to currency', () {
      final int value = 1500000;
      expect(value.formatMoney(), equals('1.500.000 đ'));
    });

    test('Formats double with decimal digits', () {
      final double value = 1234.56;
      expect(value.formatMoney(decimalDigits: 2), equals('1.234,56 đ'));
    });

    test('Gracefully handles invalid numeric strings', () {
      expect('not_a_number'.formatMoney(), equals('not_a_number'));
    });
  });
}
