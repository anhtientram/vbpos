# Workflow: routes

Routes live in `lib/presentations/routes.dart` and use `go_router`.

- Add a path to the `Routes` enum.
- Add one `GoRoute` in `AppRouter.create`.
- Construct the feature `Screen` at the route boundary and pass only its
  constructor dependencies or route arguments.
- Keep Retrofit DTOs, repository construction, and business rules out of route
  builders.
- Use `AppNavigator.go`, `AppNavigator.push`, and `AppNavigator.pop` from
  feature effects when navigation must be centralized.

`MyApp` configures the router after environment-based DI has completed and
passes it to `MaterialApp.router`. Do not bring back the removed product route
table or register feature routes in the `core` package.
