import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('StringExtensions - Validation', () {
    test('isEmail', () {
      expect('user@example.com'.isEmail, isTrue);
      expect('invalid-email'.isEmail, isFalse);
    });

    test('isPhoneNumber', () {
      expect('0901234567'.isPhoneNumber, isTrue);
      expect('+84901234567'.isPhoneNumber, isTrue);
      expect('abc'.isPhoneNumber, isFalse);
    });

    test('isNumeric', () {
      expect('123.45'.isNumeric, isTrue);
      expect('123'.isNumeric, isTrue);
      expect('abc'.isNumeric, isFalse);
    });

    test('isUrl', () {
      expect('https://flutter.dev'.isUrl, isTrue);
      expect('not a url'.isUrl, isFalse);
    });

    test('isBlank', () {
      expect('  '.isBlank, isTrue);
      expect('hello'.isBlank, isFalse);
    });
  });

  group('StringExtensions - Formatting', () {
    test('capitalizeFirst', () {
      expect('hello world'.capitalizeFirst, equals('Hello world'));
    });

    test('capitalizeWords', () {
      expect('hello world'.capitalizeWords, equals('Hello World'));
    });

    test('fromCamelCase', () {
      expect('helloWorld'.fromCamelCase, equals('Hello World'));
    });

    test('truncate', () {
      expect('Hello Flutter Developer'.truncate(10), equals('Hello F...'));
    });
  });

  group('StringExtensions - Conversion', () {
    test('toIntOrNull', () {
      expect('42'.toIntOrNull(), equals(42));
      expect('abc'.toIntOrNull(), isNull);
    });

    test('toDoubleOrNull', () {
      expect('3.14'.toDoubleOrNull(), equals(3.14));
      expect('abc'.toDoubleOrNull(), isNull);
    });

    test('toBool', () {
      expect('true'.toBool(), isTrue);
      expect('1'.toBool(), isTrue);
      expect('false'.toBool(), isFalse);
    });
  });

  group('StringExtensions - Money', () {
    test('formatMoney right symbol', () {
      expect('1000000'.formatMoney(), equals('1.000.000 đ'));
    });

    test('formatMoney left symbol', () {
      final String s = '50000';
      expect(s.formatMoney(symbol: r'$', isLeftSymbol: true), equals(r'$ 50.000'));
    });
  });

  group('StringExtensions - UI Helpers', () {
    test('initials', () {
      expect('Nguyen Van A'.initials, equals('NA'));
      expect('Flutter'.initials, equals('F'));
    });

    test('maskPhone', () {
      expect('0901234567'.maskPhone(), equals('****234567'));
    });

    test('maskEmail', () {
      expect('example@gmail.com'.maskEmail, equals('ex*****@gmail.com'));
    });

    test('fileExtension', () {
      expect('/path/to/file.dart'.fileExtension, equals('dart'));
    });

    test('isImagePath', () {
      expect('photo.png'.isImagePath, isTrue);
      expect('document.pdf'.isImagePath, isFalse);
    });
  });
}
