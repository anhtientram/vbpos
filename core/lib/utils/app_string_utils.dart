part of '../core.dart';

/// Small string helpers that are safe to use from every layer.
final class AppStringUtils {
  AppStringUtils._();

  static String? nullIfBlank(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }
}
