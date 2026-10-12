# Agent instructions — VBPos

VBPos is a clean Flutter baseline. The previous feature modules were removed;
the `sample` module is the canonical implementation to copy when adding a
feature.

Always read:

1. `.agents/README.md`
2. `.agents/progress/MODULES.md`
3. `.agents/rules/architecture.md`
4. `.agents/rules/module-standard.md`
5. `.agents/rules/localization.md`
6. `.agents/rules/shared-widgets.md`

Core decisions:

- Keep the layer-first layout: `data`, `domains`, `presentations`, and `core`;
  never create `lib/features/<feature>/...` or a second shared-helper tree.
- Use `Either<Failure, T>` from `package:core` and return `left(...)` for
  failures or `right(...)` for successes.
- Use Retrofit interfaces for HTTP and `json_serializable` DTOs. Generated
  files are produced with `dart run build_runner build --delete-conflicting-outputs`
  and must not be edited by hand.
- Domain classes use `XxxEntities` and `XxxParams`; do not add `Entity` or
  API-shaped request classes to the domain layer.
- A Screen owns Cubit wiring, effects, dialogs, and navigation. A View receives
  immutable data and callbacks and only renders.
- Keep UI models and a presentations mapper between domain entities and Views.
- User-facing text goes through `AppLocalization.current`. Add every new key to
  both ARB files, then run `dart run intl_utils:generate`.
- Search `lib/presentations/widgets/` before adding a basic widget. Keep the
  shared widget set intentionally small.
- Put shared formatters and pure utilities in `core/lib/utils/`. Use the named
  helpers there (`AppDateFormatter`, `AppCurrencyFormatter`, and
  `AppStringUtils`) from presentation code; do not create `lib/shared/`.
- Keep dependency registration split: `core` owns shared infrastructure via
  `Di`, while the app owns feature registrations via
  `DependencyInjection.init(...)` in `lib/di.dart`.
- Keep environment files, localization generation, FlutterGen, launcher icon,
  and native splash generation working.
- For adding, removing, upgrading, or troubleshooting packages, follow
  `.agents/workflows/pub-dependencies.md`.

The full workflows are in `.agents/workflows/`.
