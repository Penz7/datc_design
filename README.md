# datc_design

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**DATC Design System** - A Flutter package providing reusable UI components with consistent design tokens for colors, spacing, and typography. Built with high-performance standards and cross-platform reliability.

## 🚀 Features

- ✅ **Design Tokens**: Comprehensive set of colors, spacing scales, and typography styles.
- ✅ **Custom Widgets**:
    - `DCButton`: Variants (filled, outlined, text), loading states, and custom sizes.
    - `DCText`: Typography-driven text with default 1-line truncation.
    - `DCRichText`: Multi-span styled text using design tokens.
    - `DCList`: Native refresh and infinite scroll (load more).
    - `DCImage`: Cached network images with Shimmer loading and error handling.
    - `DCTextField` & `DCTextFieldSearch`: Form inputs with debounced search and loading indicators.
- ✅ **Material 3**: Fully compliant with Material 3 design principles.
- ✅ **Tested**: High test coverage (Unit & Widget tests).

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

## 🛠 Usage

### Button Example

```dart
DCButton(
  onPressed: () => print("Tapped"),
  label: 'Get Started',
  variant: DCButtonVariant.filled,
  size: DCButtonSize.large,
)
```

### Text with Tokens

```dart
DCText(
  'Consistent Header',
  fontSize: DCFontSize.xl,
  weight: FontWeight.bold,
  color: DCColors.primary,
)
```

### Debounced Search

```dart
DCTextFieldSearch(
  hintText: 'Search products...',
  onSearch: (query) {
    // Automatically debounced for 500ms
    print("Searching for: $query");
  },
)
```

## 🧪 Development & Testing

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

Developed for high-performance Flutter applications.
