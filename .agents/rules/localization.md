# Localization

All user-visible text must come from `AppLocalization.current`.

To add a string:

1. Add the same key to `lib/l10n/intl_vi.arb` and `lib/l10n/intl_en.arb`.
2. Run `dart run intl_utils:generate`.
3. Use the generated getter/method in Screen, View, Cubit effects, or widgets.

Generated files under `lib/l10n/gen/` are never edited manually. Domain and data
layers do not import localization. A server error message may be shown when it
is safe and non-empty; otherwise presentation falls back to a localized
feature-specific message, then `errorOccurred`.
