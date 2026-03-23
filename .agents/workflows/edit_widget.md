---
description: Workflow for editing, modifying, or removing widgets in the datc_design package
---

# Edit / Modify / Delete Widget Workflow

> Triggered when the user requests changes to existing widgets, adding features, fixing bugs, or removing widgets.

---

## Step 1: Identify the Target File

1. Determine which widget needs modification from the user's request.
2. Navigate directly to the correct file: `lib/src/widgets/dc_<widget_name>.dart`
3. Read the file to understand the current structure.

---

## Step 2: Make Changes Directly in the Widget File

- **Edit**: Use `replace_file_content` or `multi_replace_file_content` to modify the exact lines.
- **Add properties**: Add new optional parameters with DATC design token defaults.
- **Remove**: Delete the specific code block. NEVER delete a file without updating barrel exports.

### Rules during editing:
- Maintain `const` constructors if possible.
- Maintain backward compatibility — do NOT remove existing public parameters (mark `@Deprecated` if needed).
- If adding state, convert `StatelessWidget` → `StatefulWidget` properly.
- Follow all lifecycle safety rules (check `mounted`, dispose controllers).

---

## Step 3: Update Exports (if needed)

If a file was **renamed** or **deleted**:
1. Update `lib/src/widgets/index.dart`
2. Update `lib/datc_design.dart`

If a file was **added** during this edit:
1. Follow the export steps from `create_custom_widget.md` workflow.

---

## Step 4: Update Tests

1. Open `test/dc_<widget_name>_test.dart`
2. Add/modify test cases to cover the changes.
3. If a widget was **deleted**, remove the corresponding test file.

---

## Step 5: Update Example (if UI changed)

1. If the widget's visual appearance or API changed, update `example/lib/main.dart`.

---

## Step 6: Verify

// turbo
1. Run `flutter analyze` — must be ZERO issues.
2. Run `flutter test` — ALL tests must pass.
