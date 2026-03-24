import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  // ── INT EXTENSIONS ──
  group('IntExtensions - Money', () {
    test('formatMoney right symbol', () {
      final int v = 1500000;
      expect(v.formatMoney(), equals('1.500.000 đ'));
    });

    test('formatMoney left symbol', () {
      final int v = 50000;
      expect(v.formatMoney(symbol: r'$', isLeftSymbol: true), equals(r'$ 50.000'));
    });
  });

  group('IntExtensions - Duration', () {
    test('seconds', () {
      final int v = 5;
      expect(v.seconds, equals(const Duration(seconds: 5)));
    });

    test('minutes', () {
      final int v = 2;
      expect(v.minutes, equals(const Duration(minutes: 2)));
    });

    test('ms', () {
      final int v = 300;
      expect(v.ms, equals(const Duration(milliseconds: 300)));
    });
  });

  group('IntExtensions - Time Formatting', () {
    test('toTimeMMSS', () {
      final int v = 125;
      expect(v.toTimeMMSS, equals('02:05'));
    });

    test('toTimeHHMMSS', () {
      final int v = 3661;
      expect(v.toTimeHHMMSS, equals('01:01:01'));
    });
  });

  group('IntExtensions - Format', () {
    test('padWithZeros', () {
      final int v = 5;
      expect(v.padWithZeros(3), equals('005'));
    });

    test('compact', () {
      final int v1 = 1200;
      expect(v1.compact, equals('1.2K'));
      final int v2 = 1500000;
      expect(v2.compact, equals('1.5M'));
    });

    test('formatNumber', () {
      final int v = 1234567;
      expect(v.formatNumber(), equals('1.234.567'));
    });
  });

  group('IntExtensions - Spacing', () {
    test('verticalSpace', () {
      final int v = 16;
      expect(v.verticalSpace, isA<SizedBox>());
    });

    test('horizontalSpace', () {
      final int v = 16;
      expect(v.horizontalSpace, isA<SizedBox>());
    });
  });

  group('IntExtensions - Boolean / Range', () {
    test('isBetween', () {
      final int v = 5;
      expect(v.isBetween(1, 10), isTrue);
      expect(v.isBetween(6, 10), isFalse);
    });

    test('isEvenNumber / isOddNumber', () {
      final int even = 4;
      final int odd = 7;
      expect(even.isEvenNumber, isTrue);
      expect(odd.isOddNumber, isTrue);
    });
  });

  // ── DOUBLE EXTENSIONS ──
  group('DoubleExtensions - Money', () {
    test('formatMoney', () {
      final double v = 1234.56;
      expect(v.formatMoney(decimalDigits: 2), equals('1.234,56 đ'));
    });
  });

  group('DoubleExtensions - Rounding', () {
    test('roundTo', () {
      final double v = 3.14159;
      expect(v.roundTo(2), equals(3.14));
    });

    test('toFixed', () {
      final double v = 3.1;
      expect(v.toFixed(2), equals('3.10'));
    });

    test('removeTrailingZeros', () {
      final double v1 = 3.10;
      expect(v1.removeTrailingZeros, equals('3.1'));
      final double v2 = 4.0;
      expect(v2.removeTrailingZeros, equals('4'));
    });
  });

  group('DoubleExtensions - Percentage', () {
    test('toPercent', () {
      final double v = 0.856;
      expect(v.toPercent(), equals('85.6%'));
    });

    test('asPercent', () {
      final double v = 85.6;
      expect(v.asPercent(), equals('85.6%'));
    });
  });

  group('DoubleExtensions - Compact', () {
    test('compact', () {
      final double v1 = 1500.0;
      expect(v1.compact, equals('1.5K'));
      final double v2 = 2500000.0;
      expect(v2.compact, equals('2.5M'));
    });
  });

  group('DoubleExtensions - Spacing', () {
    test('circularRadius', () {
      final double v = 12.0;
      expect(v.circularRadius, isA<BorderRadius>());
    });

    test('allInsets', () {
      final double v = 16.0;
      expect(v.allInsets, equals(const EdgeInsets.all(16.0)));
    });
  });

  group('DoubleExtensions - Range', () {
    test('isBetween', () {
      final double v = 5.5;
      expect(v.isBetween(1.0, 10.0), isTrue);
      expect(v.isBetween(6.0, 10.0), isFalse);
    });
  });
}
