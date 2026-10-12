---
name: module-standardize
description: >-
  Implements or refactors VBPos modules using the layer-first architecture,
  Retrofit/json_serializable data flow, Either left/right results, and
  Screen/View presentation split.
---

# VBPos module standardization

Read `.agents/README.md`, `progress/MODULES.md`, the architecture rules, and
the matching workflow before editing code. Use the sample module as the only
golden reference.

Implementation order:

1. Define `XxxEntities`, `XxxParams`, repository contract, and use cases.
2. Add generated JSON DTOs, a Retrofit API, remote data source, mapper, and
   repository implementation.
3. Add a Screen-owned Cubit with a status enum, UI models, mapper, and a
   data-only View.
4. Register dependencies explicitly in `lib/di.dart`; do not introduce a
   service locator for a single module.
5. Add localization keys to both ARB files and regenerate.
6. Run build_runner, analyze, tests, and the repository gates.
7. Update the module board and finish workflow.

Never hand-edit generated `.g.dart`, `lib/l10n/gen/`, or `lib/core/gen/` files.
