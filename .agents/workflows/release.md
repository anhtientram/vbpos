# Workflow: release configuration

The application package name is `vbpos` and the platform identifier is
`com.biexce.vbpos.app`.

Before a release:

1. Confirm Android namespace and `applicationId` match the identifier.
2. Confirm iOS Runner build configurations and fastlane files use the new
   bundle identifier.
3. Confirm flavor entrypoints and environment files are selected explicitly.
4. Run `flutter build apk --flavor dev -t lib/main_dev.dart` or the matching
   release command.
5. Do not commit secrets, generated local env values, or stale B-Fin
   identifiers in source configuration.
