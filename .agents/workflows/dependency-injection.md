# Workflow: dependency injection

VBPos uses the `GetIt` instance exported by `package:core/core.dart`.
Registrations have two ownership levels:

1. `core/lib/di.dart` owns reusable infrastructure (`SharedPreferences` and
   `FlutterSecureStorage`) through `Di().init()`. Keep this initializer
   idempotent.
2. `lib/di.dart` owns platform, app, and feature dependencies through
   `DependencyInjection.init()`. It reads the already-loaded
   `AppEnvironment.current`, registers platform-specific `DeviceInfoPlugin`
   data, then registers the API client, Retrofit
   `AppBaseRepo`/Dio transport, data source, repository, and use cases in that
   order.

`AppInitializer.initialize` loads the selected env file first and then calls
the app DI initializer. `main.dart` must not construct repositories or use
cases directly. Presentation code may read already-registered use cases at the
composition root, but feature classes must receive their dependencies through
constructors.

When adding a module:

- add only its data source/API, repository, and use-case registrations to
  `lib/di.dart`; reuse the registered `Dio` from `AppBaseRepo`;
- register one runtime repository implementation; keep demo or fake
  repositories available for tests without selecting them from env config; and
- never register feature classes from `core/lib/di.dart`.

After changes, run `dart format`, `flutter analyze`, and the verification
workflow. If initialization is called more than once in tests or hot restart,
the code must not throw duplicate-registration errors.
