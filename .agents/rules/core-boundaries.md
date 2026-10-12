# Core boundaries

There are two intentionally separated core layers:

| Location | Allowed responsibility |
|---|---|
| `core/` package | `AppEnvironment`, `AppBaseRepo`, `Result`, transport/storage/device helpers, routing primitives, and `Either`/`Failure` |
| `lib/core/` | bootstrap orchestration, theme, snackbar, generated assets |

Do not place feature business rules in either core layer. Keep pure formatters
and general-purpose utilities in the separate `core/` package under
`core/lib/utils/`, not in presentations or a second `lib/shared/` tree. Do not
recreate `Either` or `Failure` in a feature; import them from
`package:core/core.dart`. The original `core/` base
must remain available to legacy and future modules; remove only a capability
after checking that no module, platform flow, or shared utility uses it.

`AppBaseRepo` in the `core/` package owns the single Dio configuration and
receives the loaded environment through `AppEnvironment`. Retrofit factories
use `getIt<Dio>()`; interfaces live with the feature under
`lib/data/data_source/remote/<module>/`.
