# Architecture

VBPos uses layer-first clean architecture. Do not create a feature-first tree
such as `lib/features/foo/{data,domain,presentation}`.

```text
lib/
  data/          remote data sources, Retrofit APIs, DTOs, mappers, repositories
  domains/       Entities, Params, repository contracts, use cases
  presentations/ Screens, Views, Cubits, UI models, widgets
  core/          bootstrap orchestration, theme, snackbar, app helpers
```

Dependency direction:

```text
presentations → domains ← data
lib/core and the separate core package are infrastructure helpers only.
```

Domain code never imports `data` or `presentations`. Presentation code calls
use cases and binds UI models, not DTOs. Data code maps DTOs to entities and
never contains widget or localization logic.

The separate `core/` package contains the reusable application base:
`AppBaseRepo`, `Result`, transport/storage/device helpers, `Either`,
`left`, `right`, `AsyncEither`, `Failure`, and shared formatters/utilities.
App-specific runtime configuration, theme, snackbar, and Retrofit client remain
under `lib/core`.
