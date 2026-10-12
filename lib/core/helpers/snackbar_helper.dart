import 'package:vbpos/core/themes/app_colors.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Semantic snackbars for success, error, and warning feedback.
///
/// Wraps [WidgetUtils.showSnackBar] with design-system colors so callers only
/// pass [message] (and optional actions). Use [custom] when colors fall
/// outside the standard success/error/warning palette.
final class SnackBarHelper {
  SnackBarHelper._();

  static void success(
    BuildContext context, {
    required String message,
    EdgeInsetsGeometry? margin,
    TextStyle? textStyle,
    Duration? duration,
    Widget? icon,
    String? actionLabel,
    VoidCallback? onAction,
    TextStyle? actionTextStyle,
  }) {
    _show(
      context,
      message: message,
      foregroundColor: AppColors.gray10,
      backgroundColor: AppColors.colorSnackbar,
      margin: margin,
      textStyle: textStyle,
      duration: duration,
      icon:
          icon ??
          Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 16),
          ),
      actionLabel: actionLabel,
      onAction: onAction,
      actionTextStyle: actionTextStyle,
    );
  }

  static void error(
    BuildContext context, {
    required String message,
    EdgeInsetsGeometry? margin,
    TextStyle? textStyle,
    Duration? duration,
    Widget? icon,
    String? actionLabel,
    VoidCallback? onAction,
    TextStyle? actionTextStyle,
  }) {
    _show(
      context,
      message: message,
      foregroundColor: const Color(0xFF7A1A1A),
      backgroundColor: AppColors.colorSnackbarError,
      margin: margin,
      textStyle: textStyle,
      duration: duration,
      icon:
          icon ??
          Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Color(0xFFE53935),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 16),
          ),
      actionLabel: actionLabel,
      onAction: onAction,
      actionTextStyle: actionTextStyle,
    );
  }

  static void warning(
    BuildContext context, {
    required String message,
    EdgeInsetsGeometry? margin,
    TextStyle? textStyle,
    Duration? duration,
    Widget? icon,
    String? actionLabel,
    VoidCallback? onAction,
    TextStyle? actionTextStyle,
  }) {
    _show(
      context,
      message: message,
      foregroundColor: AppColors.primary900,
      backgroundColor: AppColors.orange500,
      margin: margin,
      textStyle: textStyle,
      duration: duration,
      icon: icon,
      actionLabel: actionLabel,
      onAction: onAction,
      actionTextStyle: actionTextStyle,
    );
  }

  static void custom(
    BuildContext context, {
    required String message,
    required Color foregroundColor,
    required Color backgroundColor,
    EdgeInsetsGeometry? margin,
    TextStyle? textStyle,
    Duration? duration,
    Widget? icon,
    String? actionLabel,
    VoidCallback? onAction,
    TextStyle? actionTextStyle,
  }) {
    _show(
      context,
      message: message,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      margin: margin,
      textStyle: textStyle,
      duration: duration,
      icon: icon,
      actionLabel: actionLabel,
      onAction: onAction,
      actionTextStyle: actionTextStyle,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required Color foregroundColor,
    required Color backgroundColor,
    EdgeInsetsGeometry? margin,
    TextStyle? textStyle,
    Duration? duration,
    Widget? icon,
    String? actionLabel,
    VoidCallback? onAction,
    TextStyle? actionTextStyle,
  }) {
    final trimmed = message.trim();
    if (trimmed.isEmpty ||
        trimmed.toLowerCase() == 'null' ||
        trimmed.contains('Null check operator used on a null value')) {
      return;
    }

    WidgetUtils.showSnackBar(
      context: context,
      title: trimmed,
      color: foregroundColor,
      backgroundColor: backgroundColor,
      margin: margin,
      textStyle: textStyle,
      duration: duration,
      icon: icon,
      actionLabel: actionLabel,
      onAction: onAction,
      actionTextStyle: actionTextStyle,
    );
  }
}
