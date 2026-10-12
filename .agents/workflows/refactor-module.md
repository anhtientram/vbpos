# Workflow: refactor a module

This baseline has only the `sample` module. Refactoring means preserving
behavior while bringing code back to the standard, not reintroducing removed
product modules.

1. Record the current behavior and public entrypoints.
2. Separate domain, data, and presentation responsibilities.
3. Replace nullable/throw-based failure paths with `Either`.
4. Move API-shaped classes into `data/models` and regenerate JSON code.
5. Replace domain `Entity` names with `Entities` names in one pass.
6. Split page code into Screen/View and move Cubit wiring to Screen.
7. Add UI models and map entities in the Cubit.
8. Remove duplicated widgets and hardcoded UI text.
9. Re-run generation, analyze, tests, and repository gates.
10. Document behavior changes and update the module board.
