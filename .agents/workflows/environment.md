# Workflow: environment and flavors

Environment files live in `assets/env/` and are loaded by `core`'s
`AppEnvironment.load`, orchestrated by `lib/core/config/app_initializer.dart`.
The IDE and flavor commands use dedicated entrypoints:

| Entrypoint | File | Android flavor |
|---|---|---|
| `lib/main_local.dart` | `.env.local` | `local` |
| `lib/main_dev.dart` | `.env.dev` | `dev` |
| `lib/main_prod.dart` | `.env.prod` | `prod` |

Every environment file must provide `APP_NAME`, `ENV`, `API_BASE_URL`, and
`DEBUG_MODE`. Do not add runtime URLs or flags to Dart source.
`AppEnvironment` from `package:core/core.dart` is the only app-facing reader;
`Environments` remains only as a compatibility facade for `AppBaseRepo`.

For direct CLI runs without a flavor entrypoint, `lib/main.dart` also accepts
`--dart-define=APP_ENV=local|dev|prod`.
