# Workflow: localization

1. Add a key to both `lib/l10n/intl_vi.arb` and `lib/l10n/intl_en.arb`.
2. Keep placeholder names and types identical in both files.
3. Run `dart run intl_utils:generate`.
4. Use `AppLocalization.current.<key>` in UI code.
5. Do not edit `lib/l10n/gen/` by hand.
6. Run `flutter analyze` after generation.

Server messages may be shown only when non-empty and safe. All fallback copy is
localized; data and domain layers stay localization-free.
