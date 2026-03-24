// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

enum DateTimeFormat {
  dd_MM_YYYY,
  yyyy_MM_ddTHH_mm_ss,
  yyyy_MM_ddHHmmss,
  yyyy_MM_ddHHmm,
  yyyyMMddHHmmss,
  ddMMYYYYHHmm,
  MM_YYYY,
  YYYY_MM_dd,
  HHmm_ddMMyyyy_splash,
  HHmm,
}

extension DateTimeFormatExtension on DateTimeFormat {
  String get getString {
    switch (this) {
      case DateTimeFormat.yyyy_MM_ddTHH_mm_ss:
        return "yyyy-MM-dd'T'HH:mm:ss";
      case DateTimeFormat.dd_MM_YYYY:
        return "dd/MM/yyyy";
      case DateTimeFormat.yyyy_MM_ddHHmmss:
        return "yyyy-MM-dd HH:mm:ss";
      case DateTimeFormat.yyyy_MM_ddHHmm:
        return "yyyy-MM-dd HH:mm";
      case DateTimeFormat.ddMMYYYYHHmm:
        return "dd/MM/yyyy HH:mm";
      case DateTimeFormat.YYYY_MM_dd:
        return "yyyy-MM-dd";
      case DateTimeFormat.MM_YYYY:
        return "MM-dd";
      case DateTimeFormat.yyyyMMddHHmmss:
        return "yyyyMMdd_HHmmss";
      case DateTimeFormat.HHmm_ddMMyyyy_splash:
        return 'HH:mm dd/MM/yyyy';
      case DateTimeFormat.HHmm:
        return 'HH:mm';
    }
  }
}

class DateTimeHelper {
  static String getDateTimeNow(
      DateTimeFormat toFormat, {
        bool isFromUtc = true,
      }) {
    if (isFromUtc) {
      final date = DateTime.now().toUtc();
      return DateFormat(toFormat.getString).format(date);
    }
    final date = DateTime.now().toLocal();
    return DateFormat(toFormat.getString).format(date);
  }

  static String convertTime(
      String? dateString,
      DateTimeFormat fromFormat,
      DateTimeFormat toFormat, {
        bool isFromUtc = true,
      }) {
    if (isFromUtc) {
      final date =
      DateFormat(fromFormat.getString).parseUTC(dateString ?? "").toLocal();
      return DateFormat(toFormat.getString).format(date);
    }
    final date = DateFormat(fromFormat.getString).parse(dateString ?? "");
    return DateFormat(toFormat.getString).format(date);
  }

  static String convertMilTime(
      int milTime,
      DateTimeFormat fromFormat,
      DateTimeFormat toFormat, {
        bool isFromUtc = true,
      }) {
    if (isFromUtc) {
      final date = DateTime.fromMillisecondsSinceEpoch(
        milTime,
        isUtc: isFromUtc,
      ).toLocal();
      return DateFormat(toFormat.getString).format(date);
    }
    final date = DateTime.fromMillisecondsSinceEpoch(milTime).toLocal();
    return DateFormat(toFormat.getString).format(date);
  }

  static String convertTimeAgo(
      String dateString,
      DateTimeFormat fromFormat,
      DateTimeFormat toFormat,
      ) {
    final notificationDate =
    DateFormat(fromFormat.getString).parseUTC(dateString).toLocal();
    final now = DateTime.now();
    final difference = now.difference(notificationDate);

    if (difference.inDays > 7) {
      return convertTime(
        dateString,
        fromFormat,
        toFormat,
      );
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'vừa mới';
    }
  }

  static DateTime getDate(
      String date, {
        DateTimeFormat format = DateTimeFormat.YYYY_MM_dd,
        bool isUTC = false,
      }) {
    try {
      if (isUTC) {
        return DateFormat(format.getString).parseUTC(date).toLocal();
      }
      return DateFormat(format.getString).parse(date);
    } catch (e) {
      throw FormatException('Characters remaining after date parsing in $date');
    }
  }

  static String getString(
      DateTime date, {
        DateTimeFormat format = DateTimeFormat.YYYY_MM_dd,
      }) {
    try {
      return DateFormat(format.getString).format(date);
    } catch (e) {
      throw FormatException('Characters remaining after date parsing in $date');
    }
  }

  static String formattedTimeFromSecond(int sec) {
    // 1:00:00
    var start = 2; // minute
    var end = 7;

    if (sec >= 3600) {
      start = 0;
      if (sec >= 36000) {
        // >= 10 hours
        end = 8;
      }
    }

    return Duration(seconds: sec).toString().substring(start, end);
  }
}
