# Workflow: data layer

Use this workflow for every HTTP-backed module.

```text
Retrofit API → RemoteDataSource → RepositoryImpl → UseCase
```

- Keep Retrofit interfaces inside `lib/data/data_source/remote/<module>/`.
- Keep JSON request/response DTOs under `lib/data/models/`.
- DTOs must have generated `fromJson`/`toJson`; never hand-write repetitive
  serialization.
- Remote data sources must wrap requests with
  `ResultUtils.guardRemote(...)` from `package:core/core.dart`. This shared
  helper catches `DioException` and unexpected errors, converts them to
  `Failure`, and prevents each data source from defining its own `_failure`
  method.
- The repository maps DTOs to `XxxEntities` and propagates `left` unchanged.
- The mapper is pure and must not call Dio, localization, or a use case.
- The domain repository interface exposes `AsyncEither<T>`.
- A request DTO is not a domain Params type; the mapper constructs it.

After changing annotations or DTO fields:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Review generated diffs and run the data-layer tests.
