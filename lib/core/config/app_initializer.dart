import 'package:flutter/material.dart';
import 'package:core/core.dart';

import '../../di.dart';

class AppInitializer {
  const AppInitializer._();

  static bool _initialized = false;
  static AppEnvironment? _environment;

  static Future<AppEnvironment> initialize(String environment) async {
    if (_initialized) return _environment ?? AppEnvironment.current;

    _environment = await AppEnvironment.load(environment);
    await DependencyInjection.init();
    WidgetUtils.configLoading(const SizedBox.shrink());
    _initialized = true;
    return _environment!;
  }
}
