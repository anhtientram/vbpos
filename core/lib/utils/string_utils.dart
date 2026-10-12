part of '../core.dart';

class StringUtils {
  static String convertFloorBuildingToString({
    required String floor,
    required String buildingName,
  }) {
    return '$floor${Utils.isNullOrEmpty(floor) ? '' : ' - '}$buildingName';
  }

  static int calcDays(String? fromStr, String? toStr) {
    final from = parseDdMMyyyyHHmm(fromStr);
    final to = parseDdMMyyyyHHmm(toStr);
    if (from == null || to == null) return 1;
    final hours = to.difference(from).inHours;
    if (hours <= 0) return 1;
    final days = (hours / 24).ceil();
    return days;
  }

  static DateTime? parseDdMMyyyyHHmm(String? s) {
    if (s == null || s.isEmpty) return null;
    try {
      final parts = s.split(' ');
      final dmy = parts[0].split('/');
      final hm = parts[1].split(':');
      final dd = int.parse(dmy[0]);
      final mm = int.parse(dmy[1]);
      final yyyy = int.parse(dmy[2]);
      final hour = int.parse(hm[0]);
      final minute = int.parse(hm[1]);
      return DateTime(yyyy, mm, dd, hour, minute);
    } catch (_) {
      return null;
    }
  }

  static String buildDateRange(String? fromStr, String? toStr) {
    if (fromStr == null || toStr == null) return '';
    // Expect input as dd/MM/yyyy HH:mm
    final from = parseDdMMyyyyHHmm(fromStr);
    final to = parseDdMMyyyyHHmm(toStr);
    if (from == null || to == null) return '$fromStr - $toStr';
    String fmt(DateTime d) {
      final dd = d.day.toString().padLeft(2, '0');
      final mm = d.month.toString().padLeft(2, '0');
      final hour = d.hour.toString().padLeft(2, '0');
      final minute = d.minute.toString().padLeft(2, '0');
      return '$hour:$minute, $dd/$mm';
    }

    return '${fmt(from)} - ${fmt(to)}';
  }

  static String replacePathParams(String path, Map<String, String> params) {
    var result = path;
    params.forEach((key, value) {
      if (Utils.isNullOrEmpty(value)) {
        result = result.replaceAll('/{$key}', '');
      } else {
        result = result.replaceAll('{$key}', value);
      }
    });
    return result;
  }

  static String valueText(dynamic value, {String? type, String? unit}) {
    if (type == ValueType.phoneNumber.name) {
      if (value is String && value.length <= 8) {
        return value
            .toString()
            .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")
            .trimRight();
      }

      return value
          .toString()
          .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ")
          .trimRight();
    } else if (value is String) {
      return value;
    } else {
      return value.toString();
    }
  }

  static String convertGroundNameToString({
    required String floor,
    required String buildingName,
  }) => '$buildingName, $floor';

  static String pathWithQueryParams(String path, Map<String, dynamic> params) {
    String result = path;

    final Map<String, String> paramsString = params.map(
      (key, value) => MapEntry(key, value.toString()),
    );

    final queryParams = Uri(queryParameters: paramsString).query;

    if (queryParams.isNotEmpty) {
      result += '?$queryParams';
    }

    return result;
  }

  static String capitalizeFirstCharacter({required String s}) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  static String formatDateTime(
    DateTime dateTime, {
    String pattern = 'dd/MM/yyyy',
  }) {
    return DateFormat(pattern).format(dateTime);
  }

  static String formatCurrency(double? amount) {
    if (amount == null) return '0';
    return NumberFormat("#,###", "en_US").format(amount);
  }
}

enum ValueType { number, string, phoneNumber, ground, time, dateTime }
