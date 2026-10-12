# Workflow: shared UI

Before adding a widget:

1. Search `lib/presentations/widgets/`.
2. Check whether `AppButton`, `AppCard`, `AppTextField`, or `AppStateView`
   already covers the need.
3. Extend a primitive only when the API remains generic.
4. Keep truly feature-specific UI next to that feature.
5. Keep snackbars in `lib/core/helpers/snackbar_helper.dart`.

Do not reintroduce the old collection of duplicated badges, search bars,
shimmers, pickers, and page wrappers without a concrete second use case.
