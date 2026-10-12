# Shared widgets

The shared UI kit is intentionally small:

- `AppButton`
- `AppCard`
- `AppTextField`
- `AppStateView`

Before creating a widget, search `lib/presentations/widgets/`. Extend an
existing primitive when the behavior is generic. Add a feature-local widget
only when it cannot be reused elsewhere. Do not add duplicate search bars,
cards, buttons, empty states, or loading indicators.

Snackbars are kept in `lib/core/helpers/snackbar_helper.dart`; use that helper
for transient success and error feedback.
