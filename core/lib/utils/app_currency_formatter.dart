part of '../core.dart';

/// Currency formatting shared by all app modules.
///
/// Keep locale and grouping rules in one place so presentation code does not
/// create its own [NumberFormat] instances.
final class AppCurrencyFormatter {
  AppCurrencyFormatter._();

  static final NumberFormat _vietnamese = NumberFormat('#,##0', 'vi_VN');

  static String format(num? value, {String fallback = '0'}) {
    if (value == null) return fallback;
    return _vietnamese.format(value);
  }
}
