# Contributing to DATC Design System

Thank you for contributing to `datc_design`! This guide ensures consistency across all developers and AI assistants.

---

## 📁 Project Structure

```
datc_design/
├── lib/
│   ├── datc_design.dart              ← Main library (barrel exports only)
│   └── src/
│       ├── constants/
│       │   ├── index.dart            ← Barrel export
│       │   ├── colors.dart           ← DCColors
│       │   ├── spacing.dart          ← DCSpacing
│       │   └── font_sizes.dart       ← DCFontSize
│       ├── extensions/
│       │   ├── index.dart            ← Barrel export
│       │   └── color_extensions.dart  ← DCColorExtension
│       └── widgets/
│           ├── index.dart            ← Barrel export
│           ├── dc_button.dart        ← DCButton
│           ├── dc_text.dart          ← DCText
│           ├── dc_list.dart          ← DCList, DCListItem
│           └── dc_inkwell.dart       ← DCInkWell, DCInkWellVariant
├── test/                             ← Widget tests
├── example/lib/main.dart             ← Demo app
└── pubspec.yaml
```

---

## 📏 Rules

### Rule 1: Cross-Platform Compatibility (Android & iOS)
- ALL widgets MUST render and behave identically on both Android and iOS.
- Use `Platform`-aware logic ONLY when explicitly needed, with a fallback.
- NEVER use platform-specific APIs inside widget `build()` without a fallback.
- Use `MediaQuery`, `SafeArea`, and `LayoutBuilder` for responsive layouts.
- Use `Theme.of(context)` for dynamic theming — NEVER hardcode platform values.

### Rule 2: Widget Lifecycle Safety (Mount, Context, State)

**StatelessWidget:**
- NEVER access `context` outside of `build()`.
- NEVER store mutable state.

**StatefulWidget:**
- ALWAYS check `mounted` before `setState()` in async callbacks:
  ```dart
  if (!mounted) return;
  setState(() { /* ... */ });
  ```
- NEVER use `context` after `await` without checking `mounted`:
  ```dart
  await someAsyncOperation();
  if (!mounted) return;
  Navigator.of(context).pop();
  ```
- ALWAYS cancel `Timer`, `StreamSubscription`, `AnimationController` in `dispose()`:
  ```dart
  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();
    _timer?.cancel();
    super.dispose();
  }
  ```
- NEVER call `setState()` in `dispose()`.
- Use `late final` for controllers initialized in `initState()`.

**General:**
- Prefer `const` constructors for widget tree optimization.
- NEVER use `BuildContext` across async gaps without `mounted` guard.

### Rule 3: Export & Barrel File Convention
- **Every new file MUST be exported in its folder's `index.dart` BEFORE being used.**
- Steps when creating ANY new file:
  1. Create the `.dart` file in the correct subfolder.
  2. Add `export 'filename.dart';` to the folder's `index.dart`.
  3. Ensure `lib/datc_design.dart` re-exports the barrel file.
- `lib/datc_design.dart` MUST only contain barrel exports:
  ```dart
  export 'src/constants/index.dart';
  export 'src/extensions/index.dart';
  export 'src/widgets/index.dart';
  ```

### Rule 4: Flexible & Customizable Widget Design
- Every widget MUST accept optional parameters for customization.
- Default values MUST use `DCColors`, `DCSpacing`, `DCFontSize`.
- Use `??` operator to fall back to DATC design tokens.
- Pattern:
  ```dart
  class DCWidget extends StatelessWidget {
    const DCWidget({
      super.key,
      required this.label,
      this.color,    // Optional — defaults to DCColors.primary
      this.padding,  // Optional — defaults to DCSpacing.md
    });

    final String label;
    final Color? color;
    final EdgeInsetsGeometry? padding;

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: padding ?? const EdgeInsets.all(DCSpacing.md),
        color: color ?? DCColors.primary,
        child: DCText(label),
      );
    }
  }
  ```

### Rule 5: Naming Convention

| Item              | Convention              | Example            |
|-------------------|-------------------------|--------------------|
| File names        | `dc_<name>.dart`        | `dc_card.dart`     |
| Class names       | `DC<Name>`              | `DCCard`           |
| Enum names        | `DC<Widget><Property>`  | `DCButtonVariant`  |
| Constants classes | `DC<Category>`          | `DCColors`         |
| Extensions        | `DC<Type>Extension`     | `DCColorExtension` |
| Test files        | `dc_<name>_test.dart`   | `dc_card_test.dart`|

### Rule 6: Documentation
- Every public class, method, and property MUST have `///` doc comments.
- Every widget file MUST include a usage example in doc comments.

### Rule 7: Code Quality
- Run `flutter analyze` — ZERO warnings allowed.
- Run `flutter test` — ALL tests MUST pass.
- Use `flutter_lints` (v6.0.0+).
- Prefer `switch` expressions (Dart 3+), `final` over `var`, trailing commas.

### Rule 8: Deprecated API Avoidance
- ❌ `Color.withOpacity()` → ✅ `Color.withValues(alpha:)` or `.opacityColor()`
- ❌ `Color.value` → ✅ `Color.toARGB32()` or `.r`, `.g`, `.b`, `.a`
- ❌ `ThemeData(primarySwatch:)` → ✅ `ThemeData(colorScheme:)`
- Always `useMaterial3: true`.

---

## 🔄 Workflows

### Workflow 1: Create a New Custom Widget

**Steps (in order):**
1. Read `lib/src/constants/` and `lib/src/extensions/` to understand available design tokens.
2. Create `lib/src/widgets/dc_<name>.dart` following the naming and design rules above.
3. Add `export 'dc_<name>.dart';` to `lib/src/widgets/index.dart`.
4. Verify `lib/datc_design.dart` exports the barrel.
5. Create `test/dc_<name>_test.dart` with tests for:
   - Renders with required params only
   - Renders with all optional params customized
   - Default values match DATC design tokens
   - Interaction tests (onTap, onPressed) if applicable
   - Edge cases (empty string, overflow, null)
6. Add demo section in `example/lib/main.dart`.
7. Run `flutter analyze` (zero issues) and `flutter test` (all pass).

### Workflow 2: Edit / Modify / Delete Widget

1. Navigate to `lib/src/widgets/dc_<name>.dart` — modify directly.
2. If file renamed/deleted → update `lib/src/widgets/index.dart` and `lib/datc_design.dart`.
3. Update `test/dc_<name>_test.dart`.
4. Update `example/lib/main.dart` if UI changed.
5. Run `flutter analyze` and `flutter test`.

### Workflow 3: Upgrade Dependencies

1. Run `flutter --version` and `flutter pub outdated`.
2. Update `environment` in `pubspec.yaml`.
3. Run `flutter pub upgrade --major-versions`.
4. Run `dart fix --apply` for auto-fixes.
5. Run `flutter analyze` and `flutter test`.

---

## 🛠 Quick Commands

```bash
flutter analyze           # Check for lint issues (ZERO allowed)
flutter test              # Run all widget tests
dart format .             # Format all Dart files
dart fix --apply          # Auto-fix lint issues
flutter pub outdated      # Check outdated packages
flutter pub upgrade       # Upgrade dependencies
bash scripts/gen_ai_rules.sh  # Generate rules for Cursor & GitHub Copilot
```

---

## ✅ Before Submitting

- [ ] All widgets work on both Android and iOS
- [ ] No mount/context/state issues
- [ ] New files exported in `index.dart`
- [ ] Widgets are flexible with DATC token defaults
- [ ] `///` doc comments on all public APIs
- [ ] `flutter analyze` — 0 issues
- [ ] `flutter test` — all pass
- [ ] Example app updated
