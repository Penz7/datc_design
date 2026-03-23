# datc_design

[![Pub](https://img.shields.io/pub/v/datc_design)](https://pub.dev/packages/datc_design)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**DATC Design System** - A Flutter package providing reusable UI components with consistent design tokens for colors, spacing, and typography.

## Features

- ✅ Design tokens: Colors (primary, secondary, grayscale), spacing scale, typography styles
`DCButton` with variants (filled, outlined, text), sizes, loading states
- ✅ Material 3 compliant
- ✅ Light & Dark theme support
- ✅ Tested & Analyzed

## Getting started

Add to `pubspec.yaml`:

```yaml
dependencies:
  datc_design: ^0.1.0
```

Then run:

```bash
flutter pub get
```

Wrap your app with theme:

```dart
MaterialApp(
  theme: DatcColors.lightTheme,
  darkTheme: DatcColors.darkTheme,
  themeMode: ThemeMode.system,
  home: MyApp(),
)
```

## Usage

### DatcButton

```dart
DatcButton(
  onPressed: () {},
  label: 'Primary',
  variant: DatcButtonVariant.filled,
)

DatcButton(
  onPressed: () {},
  label: 'Outlined',
  icon: Icons.arrow_forward,
  variant: DatcButtonVariant.outlined,
  size: DatcButtonSize.large,
)

DatcButton(
  label: 'Loading',
  isLoading: true,
)
```

### Design Tokens

```dart
// Colors
Container(color: DatcColors.primary)

// Spacing
SizedBox(width: DatcSpacing.md)

// Typography
Text('Headline', style: DatcTypography.headline5)
```

## Example

See the `example/` folder for full demo.

## Themes

```dart
theme: DatcColors.lightTheme,
darkTheme: DatcColors.darkTheme,
```

## Contributing

1. Fork & clone
2. `flutter pub get`
3. `flutter analyze && flutter test`
4. Create PR

## License

MIT - see [LICENSE](LICENSE)

---

Made with ❤️ for Flutter developers.

