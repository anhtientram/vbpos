# VBPos

VBPos is a deliberately small Flutter baseline. The old product modules were
removed so new features can start from one consistent example: `sample`.

## Architecture

The repository uses layer-first clean architecture:

```text
lib/
  data/          Retrofit API, DTOs, generated JSON, mappers, repositories
  domains/       Entities, Params, repository contracts, use cases
  presentations/Screen, View, Cubit/state, UI models, shared widgets
  core/          bootstrap, theme, snackbar, and generated assets
  l10n/          ARB sources and generated AppLocalization
core/            shared package: AppEnvironment, AppBaseRepo, Result,
                 transport/storage helpers, routing primitives,
                 formatters/utilities, and Either/Failure
```

`lib/presentations/pages/sample/` is the reference module. It demonstrates
`Screen → View`, a Cubit status enum, UI models, Retrofit, generated JSON, and
`Either<Failure, T>` with `left`/`right`.

Shared infrastructure is registered by `core`'s `Di`; module dependencies are
registered by `lib/di.dart` through `DependencyInjection`.

## Commands

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run intl_utils:generate
flutter analyze
flutter test
```

Add or remove packages with Pub instead of editing dependency sections by hand:

```bash
flutter pub add package_name
flutter pub add package_name:^1.2.3
flutter pub add --dev package_name
flutter pub remove package_name
flutter pub outdated
flutter pub upgrade
flutter pub deps --style=compact
```

The complete dependency workflow, including Flutter SDK packages, local path
packages, CocoaPods refresh, generators, and recovery commands, is in
`.agents/workflows/pub-dependencies.md`.

Asset and native generation remain available:

```bash
dart run flutter_gen_runner
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

Run an environment with its dedicated entrypoint:

```bash
flutter run -t lib/main_local.dart --flavor local
flutter run -t lib/main_dev.dart --flavor dev
flutter run -t lib/main_prod.dart --flavor prod
```

The same configurations are available in `.vscode/launch.json`. `lib/main.dart`
still accepts `--dart-define=APP_ENV=...` for direct CLI use, while the IDE
profiles use the dedicated environment entrypoints. Environment files remain
in `assets/env/`; all runtime URLs and flags are read from the selected file.
All environments use the registered Retrofit repository. Change `API_BASE_URL`
in the selected env file when pointing the app to another backend. The sample
in-memory repository remains available as a test/demo helper.
