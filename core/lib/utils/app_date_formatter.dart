part of '../core.dart';

/// Date formatting and parsing shared by all app modules.
final class AppDateFormatter {
  AppDateFormatter._();

  static const String datePattern = 'dd/MM/yyyy';
  static const String dateTimePattern = 'dd/MM/yyyy HH:mm';
  static const String apiDatePattern = 'yyyy-MM-dd';

  static String formatDate(DateTime? value) =>
      format(value, pattern: datePattern);

  static String format(DateTime? value, {String pattern = dateTimePattern}) {
    if (value == null) return '';
    return DateFormat(pattern).format(value.toLocal());
  }

  static DateTime? parse(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return DateTime.tryParse(value.trim());
  }

  static String formatApiDate(String? value) {
    return format(parse(value), pattern: datePattern);
  }

  static String toApiDate(DateTime? value) {
    return value == null
        ? ''
        : DateFormat(apiDatePattern).format(value.toLocal());
  }
}
