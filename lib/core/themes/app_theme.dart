import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

class AppTheme {
  static const Color _primary = AppColors.primary500;
  static const Color _primaryLight = AppColors.primary100;
  static const Color _onPrimary = AppColors.neutral1;
  static const Color _surface = AppColors.neutral1;
  static const Color _surfaceVariant = AppColors.neutral3;
  static const Color _onSurface = AppColors.primary900;
  static const Color _error = AppColors.secondary500;
  static const Color _onError = AppColors.secondary900;
  static const Color _hint = AppColors.gray8;
  static const Color _border = Colors.transparent;
  static const Color _tabActive = AppColors.secondary500;

  static ThemeData get lightTheme {
    final text = AppTextStyle();

    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: _primary,
        onPrimary: _onPrimary,
        primaryContainer: AppColors.primary100,
        onPrimaryContainer: AppColors.primary900,
        secondary: AppColors.secondary500,
        onSecondary: _onPrimary,
        secondaryContainer: AppColors.secondary100,
        onSecondaryContainer: AppColors.secondary900,
        surface: _surface,
        onSurface: _onSurface,
        surfaceContainerHighest: AppColors.neutral3,
        error: _error,
        onError: _onError,
      ),
      scaffoldBackgroundColor: _surface,
      hintColor: _hint,
      dividerColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      textTheme: TextTheme(
        displayLarge: text.bodyXLargeMedium,
        displayMedium: text.bodyLargeMedium,
        displaySmall: text.bodyMediumMedium,
        headlineLarge: text.heading1,
        headlineMedium: text.heading2,
        headlineSmall: text.heading3,
        titleLarge: text.bodyLargeBold,
        titleMedium: text.bodyMediumBold,
        titleSmall: text.bodySmallBold,
        bodyLarge: text.bodyLargeRegular,
        bodyMedium: text.bodyMediumRegular,
        bodySmall: text.bodySmallRegular,
        labelLarge: text.bodyLargeMedium,
        labelMedium: text.bodyMediumMedium,
        labelSmall: text.bodySmallMedium,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: _primary,
        selectionColor: AppColors.primary100,
        selectionHandleColor: _primary,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: _primary,
        foregroundColor: _onPrimary,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: _onPrimary),
        actionsIconTheme: const IconThemeData(color: _onPrimary),
        titleTextStyle: text.heading2.copyWith(color: _onPrimary),
        systemOverlayStyle: AppSystemUi.overlayDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: text.bodyLargeRegular.copyWith(color: AppColors.gray8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: _border, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: _border, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: _primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: _error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: _error, width: 2),
        ),
        errorStyle: text.bodySmallRegular.copyWith(color: _error),
        errorMaxLines: 2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return const Color(0xFFE0E0E0);
            }
            return _primary;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return const Color(0xFFAAAAAA);
            }
            return _onPrimary;
          }),
          overlayColor: WidgetStateProperty.all(
            _onPrimary.withValues(alpha: 0.08),
          ),
          elevation: WidgetStateProperty.all(0),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
          textStyle: WidgetStateProperty.all(text.bodyMediumBold),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return const Color(0xFFAAAAAA);
            }
            return _primary;
          }),
          overlayColor: WidgetStateProperty.all(
            _primary.withValues(alpha: 0.06),
          ),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return const BorderSide(color: Color(0xFFE0E0E0), width: 1.5);
            }
            return const BorderSide(color: _primary, width: 1.5);
          }),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
          textStyle: WidgetStateProperty.all(text.bodyMediumBold),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return const Color(0xFFAAAAAA);
            }
            return _primary;
          }),
          overlayColor: WidgetStateProperty.all(
            _primary.withValues(alpha: 0.06),
          ),
          textStyle: WidgetStateProperty.all(text.bodyMediumMedium),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primary,
        foregroundColor: _onPrimary,
        elevation: 2,
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: _surface,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _surface,
        selectedItemColor: _primary,
        unselectedItemColor: AppColors.gray8,
        selectedLabelStyle: text.bodySmallMedium,
        unselectedLabelStyle: text.bodySmallRegular,
        showUnselectedLabels: true,
        elevation: 8,
      ),
      tabBarTheme: TabBarThemeData(
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: _tabActive, width: 2),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: _tabActive,
        unselectedLabelColor: AppColors.gray8,
        labelStyle: text.bodyMediumBold,
        unselectedLabelStyle: text.bodyMediumRegular,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primary800,
        contentTextStyle: text.bodyMediumRegular.copyWith(color: _onPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
      cardTheme: CardThemeData(
        color: _surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.neutral5, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.neutral5,
        thickness: 1,
        space: 1,
      ),
      cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: _primary),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}

/// Status-bar / navigation-bar styles for light vs dark screen backgrounds.
///
/// Most screens use a light [AppColors.neutral4] scaffold. Without an explicit
/// overlay, iOS/Android may keep light status-bar icons (from [AppBarTheme]),
/// which blend into the light background and make clock/battery unreadable.
class AppSystemUi {
  AppSystemUi._();

  /// Light app background → dark status-bar icons (clock, battery, signal).
  static const SystemUiOverlayStyle overlayLight = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.neutral1,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  /// Dark / primary app bar background → light status-bar icons.
  static const SystemUiOverlayStyle overlayDark = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.neutral1,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
