# Workflow: project bootstrap

Use this workflow after cloning VBPos or when validating a rebuilt checkout.

1. Confirm `pubspec.yaml` is named `vbpos` and the path package is `core`.
2. Confirm `assets/env/`, `assets/svg/`, and `assets/png/` are present.
3. Run `flutter pub get`.
4. Run `dart run build_runner build --delete-conflicting-outputs` and
   `dart run intl_utils:generate`.
5. Run `flutter analyze` and `flutter test`.
6. Open `lib/presentations/pages/sample/` and use it as the implementation
   reference.

Do not restore old feature folders, old service locators, or old dependencies
to make a legacy screen compile. If a capability is needed, add it through the
new module workflow.
