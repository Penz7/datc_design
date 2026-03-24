import 'package:flutter/material.dart';
import '../constants/index.dart';

/// DCRichText - A stylized rich text component extending RichText directly.
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
class DCRichText extends RichText {
  DCRichText({
    super.key,
    required List<InlineSpan> children,
    double baseFontSize = DCFontSize.normal,
    FontWeight baseWeight = FontWeight.w400,
    Color? baseColor,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.softWrap,
  }) : super(
         text: TextSpan(
           children: children,
           style: TextStyle(
             fontSize: baseFontSize,
             fontWeight: baseWeight,
             color: baseColor ?? DCColors.textPrimary,
           ),
         ),
       );
}
