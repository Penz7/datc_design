import 'package:flutter/material.dart';
import '../constants/index.dart';

/// DC Custom Text Widget extending Text directly for optimal performance.
///
/// Usage:
/// ```dart
/// DCText.base('Hello World')
/// DCText.regular('Regular text')
/// DCText.medium('Medium weight')
/// DCText.semiBold('Semi-bold text')
/// DCText.bold('Bold text')
/// ```
class DCText extends Text {
  /// Base text with no default fontWeight.
  DCText(
    super.text, {
    super.key,
    double? fontSize = DCFontSize.normal,
    Color? color,
    FontWeight? fontWeight,
    super.maxLines = 1,
    super.textAlign,
    super.overflow = TextOverflow.ellipsis,
    TextDecoration? decoration,
  }) : super(
         style: TextStyle(
           fontSize: fontSize,
           color: color ?? DCColors.textPrimary,
           fontWeight: fontWeight,
           decoration: decoration,
         ),
       );

  /// Regular weight text (w400).
  DCText.regular(
    super.text, {
    super.key,
    double? fontSize = DCFontSize.normal,
    Color? color,
    FontWeight? fontWeight = FontWeight.w400,
    super.maxLines = 1,
    super.textAlign,
    super.overflow = TextOverflow.ellipsis,
    TextDecoration? decoration,
  }) : super(
         style: TextStyle(
           fontSize: fontSize,
           color: color ?? DCColors.textPrimary,
           fontWeight: fontWeight,
           decoration: decoration,
         ),
       );

  /// Medium weight text (w500).
  DCText.medium(
    super.text, {
    super.key,
    double? fontSize = DCFontSize.normal,
    Color? color,
    FontWeight? fontWeight = FontWeight.w500,
    super.maxLines = 1,
    super.textAlign,
    super.overflow = TextOverflow.ellipsis,
    TextDecoration? decoration,
  }) : super(
         style: TextStyle(
           fontSize: fontSize,
           color: color ?? DCColors.textPrimary,
           fontWeight: fontWeight,
           decoration: decoration,
         ),
       );

  /// Semi-bold weight text (w600).
  DCText.semiBold(
    super.text, {
    super.key,
    double? fontSize = DCFontSize.normal,
    Color? color,
    FontWeight? fontWeight = FontWeight.w600,
    super.maxLines = 1,
    super.textAlign,
    super.overflow = TextOverflow.ellipsis,
    TextDecoration? decoration,
  }) : super(
         style: TextStyle(
           fontSize: fontSize,
           color: color ?? DCColors.textPrimary,
           fontWeight: fontWeight,
           decoration: decoration,
         ),
       );

  /// Bold weight text (w700).
  DCText.bold(
    super.text, {
    super.key,
    double? fontSize = DCFontSize.normal,
    Color? color,
    FontWeight? fontWeight = FontWeight.w700,
    super.maxLines = 1,
    super.textAlign,
    super.overflow = TextOverflow.ellipsis,
    TextDecoration? decoration,
  }) : super(
         style: TextStyle(
           fontSize: fontSize,
           color: color ?? DCColors.textPrimary,
           fontWeight: fontWeight,
           decoration: decoration,
         ),
       );
}
