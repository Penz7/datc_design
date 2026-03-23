import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/index.dart';
import 'dc_text.dart';

/// A custom TextField component styled according to DATC Design System.
class DCTextField extends StatelessWidget {
  const DCTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.obscureText = false,
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
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          DCText(
            labelText!,
            weight: FontWeight.w500,
            fontSize: DCFontSize.sm,
            color: DCColors.textPrimary,
          ),
          const SizedBox(height: DCSpacing.xs),
        ],
        TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          enabled: enabled,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          style: const TextStyle(
            fontSize: DCFontSize.normal,
            color: DCColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: DCColors.textSecondary,
              fontSize: DCFontSize.normal,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorText: errorText,
            filled: true,
            fillColor: enabled ? DCColors.surface : DCColors.gray100,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: DCSpacing.md,
              vertical: DCSpacing.sm,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DCSpacing.sm),
              borderSide: const BorderSide(color: DCColors.gray300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DCSpacing.sm),
              borderSide: const BorderSide(color: DCColors.gray300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DCSpacing.sm),
              borderSide: const BorderSide(color: DCColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DCSpacing.sm),
              borderSide: const BorderSide(color: DCColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DCSpacing.sm),
              borderSide: const BorderSide(color: DCColors.error, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DCSpacing.sm),
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
