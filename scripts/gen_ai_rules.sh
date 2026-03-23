#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# gen_ai_rules.sh — Auto-generate AI rules for Cursor & GitHub Copilot
# from the single source of truth: CONTRIBUTING.md + .agents/rules/
# 
# Usage: bash scripts/gen_ai_rules.sh
#        or: make gen-rules
# ═══════════════════════════════════════════════════════════════════

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

CURSOR_DIR="$PROJECT_ROOT/.cursor/rules"
GITHUB_DIR="$PROJECT_ROOT/.github"

echo "📂 Project root: $PROJECT_ROOT"
echo ""

# ─── Generate Cursor Rules ──────────────────────────────────────

echo "📝 Generating Cursor rules..."

mkdir -p "$CURSOR_DIR"

cat > "$CURSOR_DIR/datc_design.mdc" << 'CURSOR_EOF'
---
description: DATC Design System rules for the datc_design Flutter package
globs: ["lib/**/*.dart", "test/**/*.dart", "example/**/*.dart"]
---

# DATC Design System — Cursor AI Rules

You are working on `datc_design`, a Flutter design system package. Follow these rules strictly.

## Project Structure

```
lib/src/constants/   → DCColors, DCSpacing, DCFontSize (design tokens)
lib/src/extensions/  → DCColorExtension (utility extensions)
lib/src/widgets/     → DC* widgets (DCButton, DCText, DCList, DCInkWell)
lib/datc_design.dart → Main library barrel export
test/                → Widget tests
example/lib/main.dart → Demo app
```

## Mandatory Rules

### 1. Cross-Platform (Android & iOS)
- ALL widgets MUST work identically on Android and iOS.
- Use `SafeArea`, `MediaQuery`, `LayoutBuilder` for responsive layouts.
- NEVER use platform-specific APIs without a fallback in `build()`.

### 2. Widget Lifecycle Safety
- ALWAYS check `mounted` before `setState()` in async callbacks.
- NEVER use `context` after `await` without checking `mounted`.
- ALWAYS cancel Timer, StreamSubscription, AnimationController in `dispose()`.
- NEVER call `setState()` in `dispose()`.
- Prefer `const` constructors.

### 3. Barrel Export Convention
- Every new file MUST be exported in its folder's `index.dart`.
- `lib/datc_design.dart` only contains barrel exports:
  ```dart
  export 'src/constants/index.dart';
  export 'src/extensions/index.dart';
  export 'src/widgets/index.dart';
  ```

### 4. Flexible Widget Design
- All visual properties MUST be optional and customizable.
- Default values MUST use DCColors, DCSpacing, DCFontSize from constants.
- Use `??` operator to fall back to design tokens.
- Import via barrel: `import '../constants/index.dart';`

### 5. Naming Convention
- Files: `dc_<name>.dart` (e.g., `dc_card.dart`)
- Classes: `DC<Name>` (e.g., `DCCard`)
- Enums: `DC<Widget><Property>` (e.g., `DCButtonVariant`)
- Tests: `dc_<name>_test.dart` (e.g., `dc_card_test.dart`)

### 6. Documentation
- Every public class/method/property MUST have `///` doc comments.
- Every widget MUST include a usage example in doc comments.

### 7. Code Quality
- `flutter analyze` MUST have ZERO warnings.
- `flutter test` MUST pass ALL tests.
- Use trailing commas, `final` over `var`, `const` wherever possible.

### 8. Deprecated API Avoidance
- ❌ `Color.withOpacity()` → ✅ `Color.withValues(alpha:)` or `.opacityColor()`
- ❌ `Color.value` → ✅ `Color.toARGB32()` or `.r`, `.g`, `.b`, `.a`
- ❌ `ThemeData(primarySwatch:)` → ✅ `ThemeData(colorScheme:)`
- Always `useMaterial3: true`.

## Workflows

### Create a new widget:
1. Read `lib/src/constants/` and `lib/src/extensions/` first.
2. Create `lib/src/widgets/dc_<name>.dart` following all rules above.
3. Add `export 'dc_<name>.dart';` to `lib/src/widgets/index.dart`.
4. Create `test/dc_<name>_test.dart` with full test coverage.
5. Add demo section in `example/lib/main.dart`.
6. Run `flutter analyze` and `flutter test`.

### Edit a widget:
1. Modify directly in `lib/src/widgets/dc_<name>.dart`.
2. Update barrel exports if file was renamed/deleted.
3. Update tests and example app.
4. Run `flutter analyze` and `flutter test`.
CURSOR_EOF

echo "   ✅ Created: .cursor/rules/datc_design.mdc"

# ─── Generate GitHub Copilot Instructions ────────────────────────

echo "📝 Generating GitHub Copilot instructions..."

mkdir -p "$GITHUB_DIR"

cat > "$GITHUB_DIR/copilot-instructions.md" << 'COPILOT_EOF'
# DATC Design System — GitHub Copilot Instructions

You are working on `datc_design`, a Flutter design system package. Follow these rules strictly.

## Project Structure

```
lib/src/constants/   → DCColors, DCSpacing, DCFontSize (design tokens)
lib/src/extensions/  → DCColorExtension (utility extensions)
lib/src/widgets/     → DC* widgets (DCButton, DCText, DCList, DCInkWell)
lib/datc_design.dart → Main library barrel export
test/                → Widget tests
example/lib/main.dart → Demo app
```

## Mandatory Rules

### 1. Cross-Platform (Android & iOS)
- ALL widgets MUST work identically on Android and iOS.
- Use `SafeArea`, `MediaQuery`, `LayoutBuilder` for responsive layouts.
- NEVER use platform-specific APIs without a fallback in `build()`.

### 2. Widget Lifecycle Safety
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
- ALWAYS cancel Timer, StreamSubscription, AnimationController in `dispose()`.
- NEVER call `setState()` in `dispose()`.
- Prefer `const` constructors.

### 3. Barrel Export Convention
- Every new file MUST be exported in its folder's `index.dart`.
- `lib/datc_design.dart` only contains barrel exports:
  ```dart
  export 'src/constants/index.dart';
  export 'src/extensions/index.dart';
  export 'src/widgets/index.dart';
  ```
- When creating ANY new file:
  1. Create the `.dart` file in the correct subfolder.
  2. Add `export 'filename.dart';` to the folder's `index.dart`.

### 4. Flexible Widget Design
- All visual properties MUST be optional and customizable.
- Default values MUST use DCColors, DCSpacing, DCFontSize.
- Use `??` operator to fall back to design tokens.
- Import via barrel: `import '../constants/index.dart';`
- Widget template:
  ```dart
  class DCMyWidget extends StatelessWidget {
    const DCMyWidget({
      super.key,
      required this.label,
      this.color,
      this.padding,
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

### 5. Naming Convention
| Item              | Convention              | Example            |
|-------------------|-------------------------|--------------------|
| File names        | `dc_<name>.dart`        | `dc_card.dart`     |
| Class names       | `DC<Name>`              | `DCCard`           |
| Enums             | `DC<Widget><Property>`  | `DCButtonVariant`  |
| Constants classes | `DC<Category>`          | `DCColors`         |
| Extensions        | `DC<Type>Extension`     | `DCColorExtension` |
| Test files        | `dc_<name>_test.dart`   | `dc_card_test.dart`|

### 6. Documentation
- Every public class/method/property MUST have `///` doc comments.
- Every widget MUST include a usage example in doc comments.

### 7. Code Quality
- `flutter analyze` MUST have ZERO warnings.
- `flutter test` MUST pass ALL tests.
- Use trailing commas, `final` over `var`, `const` wherever possible.
- Use `flutter_lints` (v6.0.0+).

### 8. Deprecated API Avoidance
- ❌ `Color.withOpacity()` → ✅ `Color.withValues(alpha:)` or `.opacityColor()`
- ❌ `Color.value` → ✅ `Color.toARGB32()` or `.r`, `.g`, `.b`, `.a`
- ❌ `ThemeData(primarySwatch:)` → ✅ `ThemeData(colorScheme:)`
- Always `useMaterial3: true`.

## Workflows

### When creating a new widget:
1. Read `lib/src/constants/` and `lib/src/extensions/` first to understand available design tokens.
2. Create `lib/src/widgets/dc_<name>.dart` following all rules.
3. Add `export 'dc_<name>.dart';` to `lib/src/widgets/index.dart`.
4. Create `test/dc_<name>_test.dart` with tests covering:
   - Renders with required params
   - Renders with custom optional params
   - Default values match DATC tokens
   - Interaction tests (if applicable)
   - Edge cases (empty string, overflow, null)
5. Add demo section in `example/lib/main.dart`.
6. Run `flutter analyze` (zero issues) and `flutter test` (all pass).

### When editing a widget:
1. Modify directly in `lib/src/widgets/dc_<name>.dart`.
2. Maintain backward compatibility — do NOT remove public parameters (use `@Deprecated` if needed).
3. Update barrel exports if file renamed/deleted.
4. Update `test/dc_<name>_test.dart`.
5. Update `example/lib/main.dart` if UI changed.
6. Run `flutter analyze` and `flutter test`.
COPILOT_EOF

echo "   ✅ Created: .github/copilot-instructions.md"

# ─── Summary ─────────────────────────────────────────────────────

echo ""
echo "═══════════════════════════════════════════════════"
echo "  ✅ AI Rules Generated Successfully!"
echo "═══════════════════════════════════════════════════"
echo ""
echo "  📁 Cursor:         .cursor/rules/datc_design.mdc"
echo "  📁 GitHub Copilot: .github/copilot-instructions.md"
echo "  📁 Antigravity:    .agents/rules/datc_design_rules.md"
echo "  📁 Universal:      CONTRIBUTING.md"
echo ""
echo "  All rules are synced from the same source of truth."
echo ""
