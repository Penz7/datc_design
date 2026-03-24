import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('DateTimeHelper Tests', () {
    test('getString returns correct format', () {
      final date = DateTime(2024, 3, 24);
      expect(DateTimeHelper.getString(date, format: DateTimeFormat.dd_MM_YYYY), equals('24/03/2024'));
    });

    test('getDate parses correctly', () {
      final dateStr = '2024-03-24';
      final result = DateTimeHelper.getDate(dateStr, format: DateTimeFormat.YYYY_MM_dd);
      expect(result.year, equals(2024));
      expect(result.month, equals(3));
      expect(result.day, equals(24));
    });

    test('convertTimeAgo returns correct labels', () {
      final now = DateTime.now().toUtc();
      
      final justNow = now.toIso8601String();
      expect(DateTimeHelper.convertTimeAgo(justNow, DateTimeFormat.yyyy_MM_ddTHH_mm_ss, DateTimeFormat.dd_MM_YYYY), equals('vừa mới'));

      final twoHoursAgo = now.subtract(const Duration(hours: 2)).toIso8601String();
      expect(DateTimeHelper.convertTimeAgo(twoHoursAgo, DateTimeFormat.yyyy_MM_ddTHH_mm_ss, DateTimeFormat.dd_MM_YYYY), equals('2 giờ trước'));

      final threeDaysAgo = now.subtract(const Duration(days: 3)).toIso8601String();
      expect(DateTimeHelper.convertTimeAgo(threeDaysAgo, DateTimeFormat.yyyy_MM_ddTHH_mm_ss, DateTimeFormat.dd_MM_YYYY), equals('3 ngày trước'));
    });

    test('formattedTimeFromSecond converts correctly', () {
      expect(DateTimeHelper.formattedTimeFromSecond(65), equals('01:05'));
      expect(DateTimeHelper.formattedTimeFromSecond(3665), equals('1:01:05'));
    });
  });
}
