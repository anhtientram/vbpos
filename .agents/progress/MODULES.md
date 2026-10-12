# VBPos module board

This board describes the rebuilt repository. Update it whenever a module is
added, materially refactored, or verified.

| Module | Location | Status | Purpose |
|---|---|---|---|
| sample | `lib/**/sample/` | `done` | Reference CRUD module with Retrofit, generated JSON, Either, Screen/View, Cubit, and UI models |

There are no legacy product modules in this baseline. A new module starts as
`planned`, becomes `in-progress` during implementation, and may be marked
`done` only after `workflows/verification.md` and `workflows/finish-module.md`.

## Repository gates

```bash
rg 'class \w+Entity\b' lib --glob '*.dart'
rg '_entity\.dart$' lib -g '*.dart' -l
rg 'package:b_fin|name: b_fin|com\.biexce\.bfin\.app' . \
  --glob '!build/**' --glob '!.dart_tool/**' --glob '!ios/Pods/**'
```

The first two commands must return no matches. The third may only find legacy
external/generated caches while the platform migration is in progress; source
code and build configuration must use `vbpos` and `com.biexce.vbpos.app`.

## Changelog

| Date | Change |
|---|---|
| 2026-10-12 | Rebuilt the app baseline; removed old feature modules and replaced workflows |
