import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/config/app_initializer.dart';
import 'my_app.dart';

Future<void> bootstrap({String environment = 'local'}) async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  final appEnvironment = await AppInitializer.initialize(environment);
  runApp(MyApp(environment: appEnvironment));
  FlutterNativeSplash.remove();
}

const _selectedEnvironment = String.fromEnvironment(
  'APP_ENV',
  defaultValue: 'local',
);

Future<void> main() => bootstrap(environment: _selectedEnvironment);
