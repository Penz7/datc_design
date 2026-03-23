import 'package:flutter/material.dart';
import '../constants/index.dart';

/// DCRichText - A stylized rich text component that defaults to DATC tokens.
///
/// Allows composing multiple [InlineSpan]s (text spans, images, widgets)
/// while maintaining a consistent base style.
///
/// Usage:
/// ```dart
/// DCRichText(
///   baseFontSize: DCFontSize.md,
///   children: [
///     const TextSpan(text: 'I agree to the '),
///     TextSpan(
///       text: 'Terms of Service',
///       style: TextStyle(color: DCColors.primary, fontWeight: FontWeight.bold),
///     ),
///   ],
/// )
/// ```
class DCRichText extends StatelessWidget {
  const DCRichText({
    super.key,
    required this.children,
    this.baseFontSize = DCFontSize.normal,
    this.baseWeight = FontWeight.w400,
    this.baseColor,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.softWrap = true,
  });

  /// The list of [InlineSpan]s to display.
  final List<InlineSpan> children;

  /// The base font size that all children will inherit from if not overridden.
  /// Defaults to [DCFontSize.normal].
  final double baseFontSize;

  /// The base font weight that all children will inherit from if not overridden.
  /// Defaults to [FontWeight.w400].
  final FontWeight baseWeight;

  /// The base color that all children will inherit from if not overridden.
  /// Defaults to [DCColors.textPrimary].
  final Color? baseColor;

  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: children),
      style: TextStyle(
        fontSize: baseFontSize,
        fontWeight: baseWeight,
        color: baseColor ?? DCColors.textPrimary,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
