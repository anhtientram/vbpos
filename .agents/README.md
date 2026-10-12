# VBPos agent handbook

This directory is the source of truth for the rebuilt VBPos application. The
old B-Fin feature workflows were removed together with the old modules.

## Start here

1. `progress/MODULES.md` — current modules and migration status.
2. `rules/architecture.md` — layer boundaries and dependency direction.
3. `rules/module-standard.md` — the implementation contract for every module.
4. `rules/presentation-screen-view.md` — Screen/View responsibilities.
5. `rules/localization.md` — ARB and generated localization rules.
6. `rules/shared-widgets.md` — the small shared widget policy.

## Workflows

- `project-bootstrap.md` — initialize or validate the project baseline.
- `new-module.md` — add a module by copying the sample module.
- `refactor-module.md` — refactor an existing module without bypassing layers.
- `data-layer.md` — Retrofit, DTO, generated JSON, mapper, and Either flow.
- `presentation-layer.md` — Screen, View, Cubit, UI model, and status rules.
- `localization.md` — add ARB keys and regenerate `AppLocalization`.
- `shared-ui.md` — reuse or add basic widgets.
- `dependency-injection.md` — register core infrastructure and module dependencies.
- `routes.md` — add GoRouter routes and use the AppNavigator facade.
- `environment.md` — environment files and flavor entrypoints.
- `code-generation.md` — build_runner, FlutterGen, icon, and splash commands.
- `verification.md` — analyze, test, and generated-file checks.
- `release.md` — package/bundle identifiers and release checks.
- `finish-module.md` — update the board and document the result.

When a workflow conflicts with product requirements, the product requirement
wins, but the architecture and generation rules still apply unless explicitly
changed.
