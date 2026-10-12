part of 'core.dart';

final getIt = GetIt.instance;

class Di {
  static final Di _singleton = Di._internal();
  bool _initialized = false;

  factory Di() {
    return _singleton;
  }

  Di._internal();

  Future<void> init() async {
    if (_initialized) return;

    final prefs = await SharedPreferences.getInstance();

    if (!getIt.isRegistered<FlutterSecureStorage>()) {
      getIt.registerSingleton<FlutterSecureStorage>(AppSecureStorage.init());
    }
    if (!getIt.isRegistered<SharedPreferences>()) {
      getIt.registerSingleton<SharedPreferences>(prefs);
    }
    _initialized = true;
  }
}
