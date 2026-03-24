import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/index.dart';
import 'dc_text.dart';

/// A custom TextField component styled according to DATC Design System.
class DCTextField extends StatefulWidget {
  const DCTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.obscureText,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.hintStyle,
    this.borderRadius,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.fillColor,
  });

  /// Controller for the text field.
  final TextEditingController? controller;

  /// Placeholder text for the text field.
  final String? hintText;

  /// Label text for the text field.
  final String? labelText;

  /// Error message to display under the text field.
  final String? errorText;

  /// Whether the text should be obscured (e.g., for passwords).
  /// If null and [isPassword] is true, it defaults to true.
  final bool? obscureText;

  /// The type of keyboard to display.
  final TextInputType? keyboardType;

  /// The action button to display on the keyboard.
  final TextInputAction? textInputAction;

  /// Icon to show at the start of the field.
  final Widget? prefixIcon;

  /// Icon to show at the end of the field.
  /// If null and [isPassword] is true, it will provide a default password visibility toggle.
  final Widget? suffixIcon;

  /// Callback triggered when the text changes.
  final ValueChanged<String>? onChanged;

  /// Callback triggered when the user submits the form.
  final ValueChanged<String>? onSubmitted;

  /// Whether the field is interactive.
  final bool enabled;

  /// Maximum number of lines.
  final int? maxLines;

  /// Minimum number of lines.
  final int? minLines;

  /// Maximum character count.
  final int? maxLength;

  /// State-based focus control.
  final FocusNode? focusNode;

  /// Whether to focus the field automatically on page load.
  final bool autofocus;

  /// Custom text style for the input text.
  final TextStyle? textStyle;

  /// Custom text style for the hint text.
  final TextStyle? hintStyle;

  /// Custom border radius. Defaults to [DCSpacing.sm].
  final double? borderRadius;

  /// Convenience flag to set password defaults (obscure, keyboard type, suffix icon).
  final bool isPassword;

  /// Convenience flag to set email keyboard type.
  final bool isEmail;

  /// Convenience flag to set phone keyboard type.
  final bool isPhone;

  /// Custom background color.
  final Color? fillColor;

  @override
  State<DCTextField> createState() => _DCTextFieldState();
}

class _DCTextFieldState extends State<DCTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? widget.isPassword;
  }

  @override
  void didUpdateWidget(covariant DCTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText ||
        widget.isPassword != oldWidget.isPassword) {
      _obscureText = widget.obscureText ?? widget.isPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextInputType? effectiveKeyboardType = widget.keyboardType;
    if (effectiveKeyboardType == null) {
      if (widget.isEmail) {
        effectiveKeyboardType = TextInputType.emailAddress;
      } else if (widget.isPhone) {
        effectiveKeyboardType = TextInputType.phone;
      } else if (widget.isPassword) {
        effectiveKeyboardType = TextInputType.visiblePassword;
      }
    }

    Widget? effectiveSuffixIcon = widget.suffixIcon;
    if (widget.isPassword && widget.suffixIcon == null) {
      effectiveSuffixIcon = InkWell(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: DCColors.gray500,
          size: 20,
        ),
      );
    }

    final double radius = widget.borderRadius ?? DCSpacing.sm;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          DCText(
            widget.labelText!,
            fontWeight: FontWeight.w500,
            fontSize: DCFontSize.sm,
            color: DCColors.textPrimary,
          ),
          const SizedBox(height: DCSpacing.xs),
        ],
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          obscureText: _obscureText,
          keyboardType: effectiveKeyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          enabled: widget.enabled,
          maxLines: _obscureText ? 1 : widget.maxLines,
          minLines: _obscureText ? 1 : widget.minLines,
          maxLength: widget.maxLength,
          style:
              widget.textStyle ??
              const TextStyle(
                fontSize: DCFontSize.normal,
                color: DCColors.textPrimary,
              ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                const TextStyle(
                  color: DCColors.textSecondary,
                  fontSize: DCFontSize.normal,
                ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: effectiveSuffixIcon,
            errorText: widget.errorText,
            filled: true,
            fillColor:
                widget.fillColor ??
                (widget.enabled ? DCColors.surface : DCColors.gray100),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: DCSpacing.md,
              vertical: DCSpacing.sm,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: DCColors.gray300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: DCColors.gray300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: DCColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: DCColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: DCColors.error, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: DCColors.gray200),
            ),
          ),
        ),
      ],
    );
  }
}

/// A specialized TextField for searching with built-in debounce logic.
class DCTextFieldSearch extends StatefulWidget {
  const DCTextFieldSearch({
    super.key,
    this.hintText = 'Search...',
    required this.onSearch,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.controller,
    this.autofocus = false,
    this.textStyle,
    this.hintStyle,
    this.borderRadius,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.fillColor,
  });

  /// The placeholder text for the search field.
  final String hintText;

  /// Callback triggered after the user stops typing for [debounceDuration].
  final ValueChanged<String> onSearch;

  /// The wait duration after the user stops typing before calling [onSearch].
  final Duration debounceDuration;

  /// An optional external TextEditingController.
  final TextEditingController? controller;

  /// Whether the text field should focus automatically.
  final bool autofocus;

  /// Custom text style for the input text.
  final TextStyle? textStyle;

  /// Custom text style for the hint text.
  final TextStyle? hintStyle;

  /// Custom border radius. Defaults to [DCSpacing.sm].
  final double? borderRadius;

  /// Convenience flags.
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;

  /// Custom background color.
  final Color? fillColor;

  @override
  State<DCTextFieldSearch> createState() => _DCTextFieldSearchState();
}

class _DCTextFieldSearchState extends State<DCTextFieldSearch> {
  Timer? _debounce;
  late TextEditingController _controller;
  final ValueNotifier<bool> _isDebouncing = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _isDebouncing.dispose();
    // Only dispose the controller if it was created internally
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // If empty text, no need to show loading, just trigger search directly.
    if (query.isEmpty) {
      _isDebouncing.value = false;
      widget.onSearch(query);
      return;
    }

    _isDebouncing.value = true;
    _debounce = Timer(widget.debounceDuration, () {
      if (mounted) {
        _isDebouncing.value = false;
        widget.onSearch(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: _isDebouncing,
          builder: (context, isDebouncing, child) {
            Widget? suffix;

            if (isDebouncing) {
              suffix = const Padding(
                padding: EdgeInsets.all(14.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(DCColors.primary),
                  ),
                ),
              );
            } else if (value.text.isNotEmpty) {
              suffix = IconButton(
                icon: const Icon(Icons.clear, color: DCColors.gray500),
                splashRadius: 20,
                onPressed: () {
                  _controller.clear();
                  _onSearchChanged('');
                },
              );
            }

            return DCTextField(
              controller: _controller,
              hintText: widget.hintText,
              autofocus: widget.autofocus,
              textStyle: widget.textStyle,
              hintStyle: widget.hintStyle,
              borderRadius: widget.borderRadius,
              isPassword: widget.isPassword,
              isEmail: widget.isEmail,
              isPhone: widget.isPhone,
              fillColor: widget.fillColor,
              prefixIcon: const Icon(Icons.search, color: DCColors.gray500),
              suffixIcon: suffix,
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              onSubmitted: (val) {
                // Cancel debounce and search immediately if user actively submits
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _isDebouncing.value = false;
                widget.onSearch(val);
              },
            );
          },
        );
      },
    );
  }
}
