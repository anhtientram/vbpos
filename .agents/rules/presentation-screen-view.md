# Presentation: Screen and View

`*_screen.dart` is the composition root for a page:

- creates/provides the Cubit;
- triggers the initial load;
- listens for success/error effects;
- owns dialogs and navigation;
- maps Cubit state into View props.

`components/*_view.dart` receives immutable data and callbacks only. It renders
layout, calls callbacks, and never creates a Cubit, use case, repository, or
route. It must not import a data DTO or domain entity when a UI model exists.

Every Cubit state exposes a status enum such as
`initial`, `loading`, `submitting`, `success`, and `error`. The View branches on
that status and keeps the last usable data visible during a refresh.

The state holds presentation models. The Cubit maps entities through the
module's `*_presentations_mapper.dart` in the success branch.
