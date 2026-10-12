part of '../core.dart';

/// Immutable runtime configuration loaded from `assets/env/.env.<name>`.
///
/// The application must load an environment before accessing [current].
/// Keeping this strict prevents a missing env file from silently targeting an
/// unintended API.
final class AppEnvironment {
  AppEnvironment._({
    required this.appName,
    required this.name,
    required this.baseUrl,
    required this.debugMode,
  });

  static AppEnvironment? _current;

  final String appName;
  final String name;
  final String baseUrl;
  final bool debugMode;

  static Future<AppEnvironment> load(String environment) async {
    await dotenv.load(fileName: 'assets/env/.env.$environment');
    return _current = _fromDotenv();
  }

  static AppEnvironment get current {
    final environment = _current;
    if (environment == null) {
      throw StateError(
        'AppEnvironment.load must be called before AppEnvironment.current.',
      );
    }
    return environment;
  }

  /// Allows tests or an embedding application to provide a fully explicit
  /// configuration without reading a `.env` file.
  static void override({
    required String appName,
    required String name,
    required String baseUrl,
    required bool debugMode,
  }) {
    _current = AppEnvironment._(
      appName: appName,
      name: name,
      baseUrl: baseUrl,
      debugMode: debugMode,
    );
  }

  static AppEnvironment _fromDotenv() {
    return AppEnvironment._(
      appName: _required('APP_NAME'),
      name: _required('ENV'),
      baseUrl: _required('API_BASE_URL'),
      debugMode: _requiredBool('DEBUG_MODE'),
    );
  }

  static String _required(String key) {
    final value = dotenv.env[key]?.trim();
    if (value == null || value.isEmpty) {
      throw StateError('Missing required environment key: $key');
    }
    return value;
  }

  static bool _requiredBool(String key) {
    final value = _required(key).toLowerCase();
    if (value == 'true') return true;
    if (value == 'false') return false;
    throw StateError('Environment key $key must be true or false.');
  }
}

/// Compatibility facade for the original core base.
///
/// New code should use [AppEnvironment]. Existing [AppBaseRepo] integrations
/// can continue to ask [getUrl] for the configured base URL.
final class Environments {
  Environments._();

  static const String production = 'PROD';
  static const String qa = 'QA';
  static const String dev = 'DEV';
  static const String local = 'LOCAL';

  static String get currentEnvironments => AppEnvironment.current.name;

  static String getUrl() => AppEnvironment.current.baseUrl;

  static void setConfig({required String env, required String baseUrl}) {
    final current = AppEnvironment.current;
    AppEnvironment.override(
      appName: current.appName,
      name: env,
      baseUrl: baseUrl,
      debugMode: current.debugMode,
    );
  }
}

/// Persists the selected environment for legacy consumers that use [AppSP].
final class EnvironmentConfig {
  EnvironmentConfig._();

  static Future<void> setEnvironment(String value) {
    return AppSP.set(AppSP.environment, value);
  }

  static String? getEnvironment() {
    if (!getIt.isRegistered<SharedPreferences>()) return null;
    return AppSP.get<String>(AppSP.environment);
  }
}
