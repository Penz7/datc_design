---
description: Workflow for creating a new custom feature in datc_design package — triggered by "create custom feature" or "tạo một chức năng mới"
---

# Create Custom Feature Workflow

> Triggered when the user says: **"create custom feature"** or **"tạo một chức năng mới"**

---

## Step 1: Read the Design System Codebase

Read all design tokens, extensions, and existing exports:

// turbo
1. Read `lib/src/constants/index.dart` → all exported constants
2. Read `lib/src/constants/colors.dart` → `DCColors` palette
3. Read `lib/src/constants/spacing.dart` → `DCSpacing` scale
4. Read `lib/src/constants/font_sizes.dart` → `DCFontSize` scale
5. Read `lib/src/extensions/index.dart` → all exported extensions
6. Read `lib/src/extensions/color_extensions.dart` → `DCColorExtension`
7. Read `lib/datc_design.dart` → current library exports

---

## Step 2: Detect Feature Type & Scan Existing Folders

Based on the user's request, determine the feature type and scan the matching folder for existing patterns:

| Feature Type | Target Folder | Scan For |
|-------------|---------------|----------|
| Widget | `lib/src/widgets/` | Existing `dc_*.dart` files for patterns |
| Dialog | `lib/src/dialogs/` | Existing dialog implementations |
| Format | `lib/src/formats/` | Existing formatters or parsers |
| Extension | `lib/src/extensions/` | Existing extension methods |

1. List files in the matching folder to understand existing patterns.
2. Read 1–2 existing files in that folder to understand the coding style and conventions.
3. If the feature spans multiple types (e.g., widget + dialog), scan all relevant folders.

---

## Step 3: Research & Add Packages

1. Identify any packages needed for the feature (e.g., `intl` for date formatting).
2. Search pub.dev for the package using the `pub_dev_search` tool — pick the **latest stable** version.
3. Evaluate: does the package solve a problem that would take significant effort to implement manually?
   - ✅ Add it via `flutter pub add <package>` if it provides substantial value.
   - ❌ Skip it if only a single utility function is needed — implement directly.
4. Run `flutter pub get` after adding packages.

---

## Step 4: Create the Feature

1. Create the file at the appropriate location based on feature type:
   - Widget → `lib/src/widgets/dc_<feature_name>.dart`
   - Dialog → `lib/src/dialogs/dc_<feature_name>.dart`
   - Format → `lib/src/formats/dc_<feature_name>.dart`
   - Extension → `lib/src/extensions/<feature_name>_extensions.dart`

2. The feature MUST follow these conventions:
   - File name: `dc_<feature_name>.dart` (snake_case with `dc_` prefix)
   - Class name: `DC<FeatureName>` (PascalCase with `DC` prefix)
   - Import constants via barrel: `import '../constants/index.dart';`
   - Import extensions via barrel: `import '../extensions/index.dart';`

### Performance & Code Quality Rules (MANDATORY):

- **`const` constructors** with `super.key` — use `const` on every widget, collection, and object that doesn't change at runtime.
- **Explicit types** everywhere — no `dynamic`, minimize `var`. Helps Dart AOT compiler.
- **Pure `build()`** — NEVER initialize controllers, allocate objects, or trigger side effects inside `build()`. All init belongs in `initState()`.
- **Leaf-level `setState`** — `setState` wraps ONLY the smallest widget that needs rebuilding. Extract small `StatelessWidget` children to confine rebuilds.
- **Stable widget tree** — use `Visibility` / `Offstage` / `AnimatedSwitcher` instead of `if/else` widget swaps.
- **`RepaintBoundary`** — wrap complex or animated widgets to isolate repaint layers.
- **`ListView.builder`** — NEVER use `ListView(children: [...])` for dynamic lists. Always `.builder` or `SliverList`.
- **`CachedNetworkImage`** — never raw `Image.network`.
- **State management**: use `StatefulWidget` + `setState` for local UI state, `ValueNotifier` + `ValueListenableBuilder` for shared reactive values.
- **Mandatory `dispose()`** — dispose ALL controllers, subscriptions, timers, focus nodes. Check `mounted` before `setState` in async callbacks.
- **Every `addListener`** → matching `removeListener` in `dispose()`.
- **Heavy computation** → offload to `compute()` or `Isolate.run()`.
- **Cancel all `StreamSubscription`** in `dispose()`.
- **Doc comments** (`///`) on ALL public members with usage example.

### Template:
```dart
import 'package:flutter/material.dart';
import '../constants/index.dart';
import '../extensions/index.dart';

/// DC<FeatureName> - <brief description>
///
/// Usage:
/// ```dart
/// DC<FeatureName>(
///   <required_param>: <value>,
///   <optional_param>: <value>,
/// )
/// ```
class DC<FeatureName> extends StatelessWidget {
  const DC<FeatureName>({
    super.key,
    required this.<requiredParam>,
    this.<optionalParam>,
  });

  final <Type> <requiredParam>;
  final <Type>? <optionalParam>;

  @override
  Widget build(BuildContext context) {
    return <WidgetTree using DCColors, DCSpacing, DCFontSize as defaults>;
  }
}
```

---

## Step 5: Update Barrel Exports

1. **Add to the folder's `index.dart`** (create if it doesn't exist):
   ```dart
   export 'dc_<feature_name>.dart';
   ```

2. **Verify `lib/datc_design.dart`** exports the folder's barrel.
   - If not yet exported, add: `export 'src/<folder>/index.dart';`

---

## Step 6: Create Unit Tests

1. Create test at `test/dc_<feature_name>_test.dart`
2. Test cases MUST include:
   - ✅ **Renders correctly** with required parameters only
   - ✅ **Renders correctly** with all optional parameters customized
   - ✅ **Default values** match DATC design tokens
   - ✅ **Interaction** tests (onTap, onPressed, etc.) if applicable
   - ✅ **Loading/disabled state** if applicable
   - ✅ **Edge cases** (empty string, null values, overflow text, etc.)
   - ✅ **Dispose** — verify no leaks (controllers disposed properly)

### Test Template:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('DC<FeatureName> Tests', () {
    testWidgets('renders with required params', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DC<FeatureName>(<required>: <value>),
          ),
        ),
      );
      expect(find.byType(DC<FeatureName>), findsOneWidget);
    });

    testWidgets('applies custom styling', (tester) async {
      // Test with all optional params
    });

    testWidgets('handles interaction', (tester) async {
      // Test callbacks
    });

    testWidgets('renders edge cases', (tester) async {
      // Test empty, overflow, etc.
    });
  });
}
```

---

## Step 7: Verify

// turbo
1. Run `flutter analyze` in the project root — must have ZERO issues.
2. Run `flutter test` — ALL tests must pass.
3. Review code one more time against the performance rules above.

---

## Checklist Summary

- [ ] Read constants & extensions
- [ ] Detect feature type & scan existing folder
- [ ] Research & add packages (if needed)
- [ ] Create `dc_<name>.dart` in the correct folder with all optimization rules
- [ ] Export in folder's `index.dart`
- [ ] Export in `lib/datc_design.dart` (if not already)
- [ ] Create `test/dc_<name>_test.dart` with full coverage
- [ ] `flutter analyze` passes
- [ ] `flutter test` passes
