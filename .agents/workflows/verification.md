# Workflow: verification

Before declaring work complete:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run intl_utils:generate
flutter analyze
flutter test
```

Then verify:

```bash
rg 'class \w+Entity\b' lib --glob '*.dart'
rg '_entity\.dart$' lib -g '*.dart' -l
rg 'package:b_fin|name: b_fin|com\.biexce\.bfin\.app' lib pubspec.yaml android ios \
  --glob '!ios/Pods/**' --glob '!**/build/**'
```

The first two searches must be empty. The rename search must be empty in app
source/configuration. Review generated files are present and the selected
flavor opens the sample module successfully.
