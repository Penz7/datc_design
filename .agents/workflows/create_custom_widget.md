---
description: Workflow for creating a new custom widget in datc_design package — triggered by "create a custom widget" or "tạo cho tôi custom widget"
---

# Create Custom Widget Workflow

> Triggered when the user says: **"create a custom widget"** or **"tạo cho tôi custom widget"**

---

## Step 1: Read the Design System Codebase

Read all design tokens and extensions to understand available constants:

// turbo
1. Read `lib/src/constants/index.dart` → to see all exported constants
2. Read `lib/src/constants/colors.dart` → `DCColors` palette
3. Read `lib/src/constants/spacing.dart` → `DCSpacing` scale
4. Read `lib/src/constants/font_sizes.dart` → `DCFontSize` scale
5. Read `lib/src/extensions/index.dart` → to see all exported extensions
6. Read `lib/src/extensions/color_extensions.dart` → `DCColorExtension`
7. Read `lib/datc_design.dart` → to see current library exports

---

## Step 2: Create the Widget File

1. Create the new widget file at `lib/src/widgets/dc_<widget_name>.dart`
2. The widget MUST follow these conventions:
   - File name: `dc_<widget_name>.dart` (snake_case with `dc_` prefix)
   - Class name: `DC<WidgetName>` (PascalCase with `DC` prefix)
   - Import constants via barrel: `import '../constants/index.dart';`
   - Import extensions via barrel: `import '../extensions/index.dart';`
   - Use `const` constructor with `super.key`
   - Default values MUST use `DCColors`, `DCSpacing`, `DCFontSize`
   - All visual properties MUST be customizable via optional parameters
   - Include `///` doc comments for ALL public members
   - Include a usage example in doc comments
   - Check `mounted` before `setState` in `StatefulWidget`
   - Cancel all controllers/subscriptions in `dispose()`

### Template:
```dart
import 'package:flutter/material.dart';
import '../constants/index.dart';
import '../extensions/index.dart';

/// DC<WidgetName> - <brief description>
///
/// Usage:
/// ```dart
/// DC<WidgetName>(
///   <required_param>: <value>,
///   <optional_param>: <value>,
/// )
/// ```
class DC<WidgetName> extends StatelessWidget {
  const DC<WidgetName>({
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

## Step 3: Update Barrel Exports

1. **Add to `lib/src/widgets/index.dart`** (create file if it doesn't exist):
   ```dart
   export 'dc_<widget_name>.dart';
   ```

2. **Verify `lib/datc_design.dart`** exports the widgets barrel:
   - If individual widget exports exist, add: `export 'src/widgets/dc_<widget_name>.dart';`
   - OR migrate to barrel: `export 'src/widgets/index.dart';`

---

## Step 4: Create Test File

1. Create test at `test/dc_<widget_name>_test.dart`
2. Test cases MUST include:
   - ✅ **Renders correctly** with required parameters only
   - ✅ **Renders correctly** with all optional parameters customized
   - ✅ **Default values** match DATC design tokens
   - ✅ **Interaction** tests (onTap, onPressed, etc.) if applicable
   - ✅ **Loading/disabled state** if applicable
   - ✅ **Edge cases** (empty string, null values, overflow text, etc.)

### Test Template:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datc_design/datc_design.dart';

void main() {
  group('DC<WidgetName> Tests', () {
    testWidgets('renders with required params', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DC<WidgetName>(<required>: <value>),
          ),
        ),
      );
      expect(find.byType(DC<WidgetName>), findsOneWidget);
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

## Step 5: Add to Example App

1. Create a new demo page at `example/lib/components/dc_<widget_name>_demo.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:datc_design/datc_design.dart';
import 'shared.dart';

class DC<WidgetName>Demo extends StatelessWidget {
  const DC<WidgetName>Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'DC<WidgetName>',
      children: [
        const SectionTitle('<section>'),
        DC<WidgetName>(<demo params>),
      ],
    );
  }
}
```

2. Open `example/lib/main.dart` and add:
   - Import: `import 'components/dc_<widget_name>_demo.dart';`
   - New `_MenuItem` entry in the `menuItems` list:
     ```dart
     _MenuItem(
       title: 'DC<WidgetName>',
       subtitle: '<brief description>',
       icon: Icons.<relevant_icon>,
       page: const DC<WidgetName>Demo(),
     ),
     ```

---

## Step 6: Verify

// turbo
1. Run `flutter analyze` in the project root — must have ZERO issues.
2. Run `flutter test` — ALL tests must pass.
3. Run the example app to visually verify on both platforms.

---

## Checklist Summary

- [ ] Read constants & extensions
- [ ] Create `lib/src/widgets/dc_<name>.dart` with proper conventions
- [ ] Export in `lib/src/widgets/index.dart`
- [ ] Export in `lib/datc_design.dart`
- [ ] Create `test/dc_<name>_test.dart` with full coverage
- [ ] Add demo page in `example/lib/components/dc_<name>_demo.dart`
- [ ] Add `_MenuItem` entry in `example/lib/main.dart`
- [ ] `flutter analyze` passes
- [ ] `flutter test` passes
