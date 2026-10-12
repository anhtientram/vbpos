# Workflow: presentation layer

Use this workflow for a new or changed screen.

1. Add `*_model.dart` and `*_presentations_mapper.dart`.
2. Add a Cubit library with `part '*_state.dart'`.
3. Make the state expose a status enum and immutable UI model fields.
4. Have the Cubit call use cases and use `fold(left, right)` to emit state.
5. Let the Screen create the Cubit, trigger initial loading, and listen for
   snackbar/dialog effects.
6. Let the View receive models, flags, and callbacks. It must not fetch, route,
   create Cubits, or depend on DTOs.
7. Keep the last list visible while a refresh is loading.
8. Use `SnackBarHelper` for transient messages and localized strings for every
   label, title, hint, empty state, and error fallback.

The View is complete when it can be previewed with fake state and callbacks,
without constructing a repository.
