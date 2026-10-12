# Workflow: finish a module

1. Run `verification.md` completely.
2. Check the Screen/View split and the shared widget search.
3. Check both ARB files and generated localization.
4. Check generated Retrofit/JSON files are up to date.
5. Update `progress/MODULES.md` with status, location, and a short note.
6. Add a dated changelog row for behavior or architecture changes.
7. Summarize commands run and any environment-specific limitation.

Never mark a module `done` because it merely compiles; the Either flow,
generated code, localization, tests, and naming gates must all pass.
