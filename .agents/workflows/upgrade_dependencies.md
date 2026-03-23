---
description: Workflow for upgrading Flutter, Dart SDK, and package dependencies
---

# Upgrade Dependencies Workflow

> Triggered when the user requests upgrading packages, SDK, or checking for outdated dependencies.

---

## Step 1: Check Current Versions

// turbo
1. Run `flutter --version` to check current Flutter and Dart SDK.
2. Run `flutter pub outdated` to see all outdated direct and transitive dependencies.

---

## Step 2: Upgrade SDK Constraints

1. Open `pubspec.yaml`
2. Update the `environment` section to the latest stable versions:
   ```yaml
   environment:
     sdk: ^<latest_dart_sdk>
     flutter: ">=<latest_flutter>"
   ```
3. Always verify the latest stable version by searching the web first.

---

## Step 3: Upgrade Dependencies

// turbo
1. Run `flutter pub upgrade --major-versions` to upgrade all direct dependencies.
2. Run `flutter pub get` to resolve.

---

## Step 4: Fix Breaking Changes

1. Run `flutter analyze` to check for new deprecation warnings or errors.
// turbo
2. Run `dart fix --apply` to auto-fix known deprecations.
3. Manually fix any remaining issues.

---

## Step 5: Verify

// turbo
1. Run `flutter analyze` — zero issues.
2. Run `flutter test` — all tests pass.
3. Test the example app on both Android and iOS.
