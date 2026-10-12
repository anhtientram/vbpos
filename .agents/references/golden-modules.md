# Reference module

`lib/presentations/pages/sample/` is the only golden module in this baseline.
Its data flow is:

```text
Retrofit DTO → remote data source → repository → Either<Failure, Entities>
→ use case → Cubit → presentations mapper → UI model → View
```

Copy its shape, not its feature name. Keep the module small until its API and
screen behavior are proven.
