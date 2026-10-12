# Workflow: Pub dependencies

Run all commands from the repository root unless the command explicitly uses
the `core/` package.

## Add a package to the app

Use `flutter pub add` so Pub updates both `pubspec.yaml` and the lockfile:

```bash
# Runtime package
flutter pub add package_name

# Runtime package with a version constraint
flutter pub add package_name:^1.2.3

# Development-only package (test, generator, linter, and so on)
flutter pub add --dev package_name

# Flutter SDK package
flutter pub add flutter_localizations --sdk=flutter

# Local package by path
flutter pub add core --path=./core
```

For this repository:

```bash
# Retrofit and JSON runtime packages
flutter pub add dio
flutter pub add retrofit
flutter pub add json_annotation

# Retrofit/JSON generators
flutter pub add --dev build_runner
flutter pub add --dev json_serializable
flutter pub add --dev retrofit_generator
```

Do not add a package to `dependencies` when it is only used by tests or code
generation. Put it in `dev_dependencies` with `--dev`.

## Remove or inspect packages

```bash
# Remove a package from pubspec.yaml and pubspec.lock
flutter pub remove package_name

# Resolve dependencies after editing pubspec.yaml manually
flutter pub get

# Show packages that can be upgraded
flutter pub outdated

# Upgrade within the existing version constraints
flutter pub upgrade

# Upgrade and rewrite constraints to the newest compatible major versions
flutter pub upgrade --major-versions

# Inspect the resolved dependency tree
flutter pub deps --style=compact
```

Use `flutter pub upgrade --major-versions` deliberately because it can change
the version constraints in `pubspec.yaml`. Review the resulting lockfile and
run the verification workflow afterward.

If the package belongs to the shared `core/` package, resolve that package as
well:

```bash
cd core
flutter pub get
cd ..
flutter pub get
```

## Required commands after adding a package

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run intl_utils:generate
dart run flutter_gen_runner
flutter analyze
flutter test
```

Only run the generation command affected by the change. `build_runner` owns
Retrofit and JSON files, `intl_utils` owns localization output, and
`flutter_gen_runner` owns `lib/core/gen/assets.gen.dart`.

When a newly added package includes an iOS native plugin, refresh CocoaPods:

```bash
cd ios
pod install
cd ..
```

Then run the relevant flavor:

```bash
flutter run -t lib/main_local.dart --flavor local
flutter run -t lib/main_dev.dart --flavor dev
flutter run -t lib/main_prod.dart --flavor prod
```

## Recovery commands

Use these only when dependency metadata or generated outputs are stale:

```bash
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

`dart pub cache repair` is a machine-wide cache repair and should be a last
resort; it is not part of the normal project workflow.
