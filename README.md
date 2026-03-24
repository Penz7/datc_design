# datc_design

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**DATC Design System** - A Flutter package providing reusable UI components with consistent design constants for colors, spacing, and typography. Built with high-performance standards and cross-platform reliability.

## 🚀 Overview

- ✅ **Design Constants**: Comprehensive set of colors, spacing scales, and typography styles.
- ✅ **Custom UI Components**: A collection of cross-platform widgets optimized for consistent branding.
- ✅ **Performance**: Integrated caching and optimized rendering.
- ✅ **Material 3**: Fully compliant with modern Material principles.
- ✅ **Stability**: Enforced through rigorous testing and code analysis.

## 📦 Installation

Since this package is not yet published on pub.dev, add it to your `pubspec.yaml` via GitHub:

```yaml
dependencies:
  datc_design:
    git:
      url: https://github.com/Penz7/datc_design.git
      ref: main
```

Then run:

```bash
flutter pub get
```

## 🛠 Usage Examples

### UI Components

```dart
DCButton(
  onPressed: () => print("Tapped"),
  label: 'Get Started',
  variant: DCButtonVariant.filled,
  size: DCButtonSize.large,
)

DCTextFieldSearch(
  hintText: 'Search products...',
  onSearch: (query) => print(query),
)
```

### Design Constants

```dart
DCText(
  'Consistent Header',
  fontSize: DCFontSize.xl,
  weight: FontWeight.bold,
  color: DCColors.primary,
)

SizedBox(height: DCSpacing.md)
```

## 🧪 Development

We maintain strict technical standards. Every contribution must pass analysis and testing.

```bash
# Analyze code quality
flutter analyze

# Run all unit and widget tests
flutter test
```

## 📜 License

MIT - see [LICENSE](LICENSE)

---

## MORE Package recommend for developer
```
  wolt_modal_sheet
  modal_bottom_sheet
```

Developed for high-performance Flutter applications using consistent design constants.
