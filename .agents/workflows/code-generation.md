# Workflow: code generation

Run these commands from the repository root:

```bash
dart run build_runner build
dart run intl_utils:generate
dart run flutter_gen_runner
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

`build_runner` owns Retrofit and JSON `.g.dart` files. `intl_utils` owns
`lib/l10n/gen/`. FlutterGen owns `lib/core/gen/assets.gen.dart`. Generated
files are outputs: do not edit them manually. If a generated file conflicts,
fix the source annotation/configuration and run the command again.
