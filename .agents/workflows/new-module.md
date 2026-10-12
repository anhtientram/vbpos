# Workflow: add a new module

1. Add the module row to `progress/MODULES.md` as `planned`.
2. Copy the sample module's layer-first shape and rename every type.
3. Define domain entities and params without importing data or Flutter.
4. Define the repository contract with `AsyncEither<T>`.
5. Add request/response DTOs with `@JsonSerializable()` and `part` files.
6. Add a Retrofit API with `@RestApi()` and a remote data source that maps
   transport failures to `left(Failure(...))`.
7. Map DTOs to entities in a pure data mapper and implement the repository.
8. Add one use case per action.
9. Add UI models and a presentations mapper.
10. Add a Cubit/state with a status enum, then a Screen-owned provider and a
    data-only View.
11. Reuse the basic presentation widgets, core formatters/utilities, and add
    localization keys in both ARBs.
12. Register the module in `lib/di.dart` and compose it from the app entrypoint.
13. Run `dart run build_runner build`, `dart run intl_utils:generate`, analyze,
    tests, and the gates in `verification.md`.
14. Mark the board `done` only through `finish-module.md`.
