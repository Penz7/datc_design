import 'package:flutter/material.dart';
import '../constants/index.dart';

/// DC Custom Text Widget with simple size param
class DCText extends StatelessWidget {
  const DCText(
    this.data, {
    super.key,
    this.fontSize = DCFontSize.normal,
    this.weight = FontWeight.w400,
    this.color,
    this.maxLines,
    this.textAlign,
  });

  final String data;
  final double fontSize;
  final FontWeight weight;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: weight,
        color: color ?? DCColors.textPrimary,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
