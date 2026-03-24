---
description: Workflow for editing, modifying, or removing features in the datc_design package — triggered by "edit feature" or "chỉnh sửa chức năng"
---

# Edit / Modify / Delete Feature Workflow

> Triggered when the user requests changes to existing features, adding functionality, fixing bugs, or removing features.

---

## Step 1: Identify the Target File

1. Determine which feature needs modification from the user's request.
2. Locate the file in the appropriate folder:
   - Widget → `lib/src/widgets/dc_<name>.dart`
   - Dialog → `lib/src/dialogs/dc_<name>.dart`
   - Format → `lib/src/formats/dc_<name>.dart`
   - Extension → `lib/src/extensions/<name>_extensions.dart`
3. Read the file to understand the current structure.

---

## Step 2: Make Changes

- **Edit**: Use `replace_file_content` or `multi_replace_file_content` to modify exact lines.
- **Add properties**: Add new optional parameters with DATC design token defaults.
- **Remove**: Delete the specific code block. NEVER delete a file without updating barrel exports.

### Rules during editing (MANDATORY):

- **Maintain `const`** constructors if possible.
- **Backward compatibility** — do NOT remove existing public parameters (mark `@Deprecated` if needed).
- If adding state, convert `StatelessWidget` → `StatefulWidget` properly.
- **Pure `build()`** — no controller init, no side effects inside `build()`.
- **Leaf-level `setState`** — only wrap the smallest widget that needs rebuilding.
- **Stable widget tree** — `Visibility` / `Offstage` / `AnimatedSwitcher`, not `if/else` swaps.
- **Explicit types** — no `dynamic`, minimize `var`.
- **Mandatory `dispose()`** — dispose all controllers, subscriptions, timers, focus nodes.
- **Check `mounted`** before `setState` in async callbacks.
- **Every `addListener`** → matching `removeListener` in `dispose()`.
- **`ListView.builder`** — never `ListView(children: [...])` for dynamic lists.
- **`CachedNetworkImage`** — never raw `Image.network`.
- **Heavy work** → `compute()` / `Isolate.run()`, not on main thread.
- **State management**: `StatefulWidget` + `setState` for local state, `ValueNotifier` + `ValueListenableBuilder` for shared reactive values.

---

## Step 3: Update Exports (if needed)

If a file was **renamed** or **deleted**:
1. Update the folder's `index.dart`
2. Update `lib/datc_design.dart`

If a file was **added** during this edit:
1. Follow the export steps from `create_custom_feature.md` workflow.

---

## Step 4: Update Tests

1. Open `test/dc_<feature_name>_test.dart`
2. Add/modify test cases to cover the changes.
3. If a feature was **deleted**, remove the corresponding test file.
4. Ensure tests cover:
   - ✅ Changed behavior
   - ✅ Edge cases
   - ✅ Dispose / memory leak verification (if controllers were added/changed)

---

## Step 5: Update Example (if UI changed)

1. If the feature's visual appearance or API changed, update the corresponding demo page at `example/lib/components/dc_<feature_name>_demo.dart`.
2. If the feature was **deleted**, also remove its demo file and the `_MenuItem` entry in `example/lib/main.dart`.

---

## Step 6: Verify

// turbo
1. Run `flutter analyze` — must be ZERO issues.
2. Run `flutter test` — ALL tests must pass.
3. Review code one more time against the performance rules in Step 2.
