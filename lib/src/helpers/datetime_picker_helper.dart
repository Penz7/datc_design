import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import '../constants/index.dart';

class DateTimePickerHelper {
  static final instance = DateTimePickerHelper._();

  DateTimePickerHelper._();

  void showDateTimePicker(
    Function(DateTime) callback, {
    required BuildContext context,
    DateTime? now,
    picker.LocaleType locale = picker.LocaleType.en,
    int subtractYear = 5,
  }) {
    final temp = now ?? DateTime.now();
    picker.DatePicker.showDateTimePicker(
      context,
      minTime: DateTime(temp.year - subtractYear, 0, 0),
      maxTime: DateTime(temp.year + subtractYear, 0, 0),
      theme: const picker.DatePickerTheme(
        headerColor: DCColors.surface,
        backgroundColor: DCColors.surface,
        itemStyle: TextStyle(
          color: DCColors.textPrimary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
        doneStyle: TextStyle(
          color: DCColors.secondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.w600,
        ),
        cancelStyle: TextStyle(
          color: DCColors.textSecondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      currentTime: temp,
      locale: locale,
    );
  }

  void showTimePicker(
    Function(DateTime) callback, {
    required BuildContext context,
    picker.LocaleType locale = picker.LocaleType.en,
    int subtractYear = 5,
  }) {
    picker.DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      theme: const picker.DatePickerTheme(
        headerColor: DCColors.surface,
        backgroundColor: DCColors.surface,
        itemStyle: TextStyle(
          color: DCColors.textPrimary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
        doneStyle: TextStyle(
          color: DCColors.secondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.w600,
        ),
        cancelStyle: TextStyle(
          color: DCColors.textSecondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      locale: locale,
    );
  }

  void showDatePicker(
    Function(DateTime) callback, {
    required BuildContext context,
    DateTime? now,
    picker.LocaleType locale = picker.LocaleType.en,
    int subtractYear = 5,
    bool disableFuture = false,
    bool isBirthday = false,
  }) {
    final temp = now ?? DateTime.now();
    picker.DatePicker.showDatePicker(
      context,
      minTime: DateTime(temp.year - subtractYear, 0, 0),
      maxTime: isBirthday
          ? DateTime.now()
          : DateTime(temp.year + (disableFuture ? 0 : subtractYear), 0, 0),
      theme: const picker.DatePickerTheme(
        headerColor: DCColors.surface,
        backgroundColor: DCColors.surface,
        itemStyle: TextStyle(
          color: DCColors.textPrimary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
        doneStyle: TextStyle(
          color: DCColors.secondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.w600,
        ),
        cancelStyle: TextStyle(
          color: DCColors.textSecondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      currentTime: temp,
      locale: locale,
    );
  }

  void showDatePickerWithMinTime(
    Function(DateTime) callback, {
    required BuildContext context,
    DateTime? now,
    picker.LocaleType locale = picker.LocaleType.en,
    required DateTime minTime,
  }) {
    final temp = now ?? DateTime.now();
    picker.DatePicker.showDatePicker(
      context,
      minTime: minTime,
      theme: const picker.DatePickerTheme(
        headerColor: DCColors.surface,
        backgroundColor: DCColors.surface,
        itemStyle: TextStyle(
          color: DCColors.textPrimary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
        doneStyle: TextStyle(
          color: DCColors.secondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.w600,
        ),
        cancelStyle: TextStyle(
          color: DCColors.textSecondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      currentTime: temp,
      locale: locale,
    );
  }

  void showDatePickerWithMaxTime(
    Function(DateTime) callback, {
    required BuildContext context,
    DateTime? now,
    picker.LocaleType locale = picker.LocaleType.en,
    required DateTime maxTime,
  }) {
    final temp = now ?? DateTime.now();
    picker.DatePicker.showDatePicker(
      context,
      maxTime: maxTime,
      theme: const picker.DatePickerTheme(
        headerColor: DCColors.surface,
        backgroundColor: DCColors.surface,
        itemStyle: TextStyle(
          color: DCColors.textPrimary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
        doneStyle: TextStyle(
          color: DCColors.secondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.w600,
        ),
        cancelStyle: TextStyle(
          color: DCColors.textSecondary,
          fontSize: DCFontSize.normal,
          fontWeight: FontWeight.normal,
        ),
      ),
      onConfirm: (date) {
        callback(date);
      },
      currentTime: temp,
      locale: locale,
    );
  }
}
