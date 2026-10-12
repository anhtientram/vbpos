---
name: module-standardize
description: >-
  Implements or refactors b-fin-client feature modules to the repo Result/Params
  standard, updates MODULES.md progress. Use when the user asks to implement a
  module, refactor legacy modules (contract, investor, expense, debt-reminder,
  payments), standardize data/domain/presentation, or continue from the module
  status board.
---

# Module standardize

## Required first reads

1. `.agents/progress/MODULES.md`
2. `.agents/rules/module-standard.md`
3. `.agents/rules/localization.md`
4. `.agents/rules/shared-widgets.md`
5. `.agents/rules/presentation-screen-view.md`
6. `.agents/workflows/routes.md` (when adding/changing GoRoutes)
7. `.agents/references/golden-modules.md`
8. Matching workflow — **read first, then code from it**:
   - New / stub → `.agents/workflows/implement-module.md`
   - Legacy / partial → `.agents/workflows/refactor-module.md`
   - Profile / user-manager CCCD + dates / update-without-getMe → `.agents/workflows/profile-and-user-identity.md`
   - Tickets (chi=PAYMENT, thu=RECEIPT, shared print view) → `.agents/workflows/ticket.md`
   - Send progress overlay (`showProgressLoading`) → `.agents/workflows/send-progress.md`
   - If behavior is not in a workflow yet, add/update the workflow in the same session

## Execution

1. Confirm target module (user-named, or next `legacy` on the board — prefer expense/debt-reminder before contract).
2. Use warehouse/customer/assets as templates for DS → mapper → repo → usecase → cubit.
3. Keep layer-first paths; do not create `lib/features/...`.
4. Domain naming: `*_entities.dart` / `XxxEntities` (rename away from `Entity` when refactoring).
5. Mapper builds requests with `RequestQueryHelper`; remote DS uses `BaseRepository.parseResponse` after `Result.guardAsync` (no private `_parseResponse`); request/response files follow customer/warehouse naming (`toJson`, `*ListPaginationParams`).
6. Presentation: Screen wires Cubit (**owns** `BlocProvider` + initial `load*`) and passes data into View; View renders only. Every State has a status enum. **Required:** `models/<feature>_model.dart` + `models/<feature>_presentations_mapper.dart` — Cubit maps `*Entities` → UI models (twin: `warehouse-management/models/`); State/View hold models, not domain entities for list/detail. Do not add feature Cubits to `main_page.dart`; Main-tab ownership: `.agents/workflows/main-tab-cubit-ownership.md` (expense/investor/debt on Screen; contract deferred). **Routes:** `.agents/workflows/routes.md` — `GoRoute` → Screen ctor args only; do not wrap `BlocProvider`/`getIt` in `routes.dart`. Do not start the routes one-pass unless the user asks.
7. **Before any new widget:** search `lib/presentations/widgets/` and reuse (see shared-widgets rule).
8. No hardcoded UI copy — prefer feature `AppLocalization` key; else `errorOccurred`. New strings → both ARB files + save (auto-gen).
9. Run analyze on touched files.
10. **Always** finish with `.agents/workflows/mark-module-done.md` (update status + changelog). If product behavior changed, update the matching file under `.agents/workflows/` in the same session.

## Done criteria

See checklist in `.agents/workflows/mark-module-done.md`. If incomplete, mark `partial` with Notes — never leave the board stale.
