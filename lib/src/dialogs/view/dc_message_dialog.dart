import 'package:flutter/material.dart';
import '../../constants/index.dart';
import '../../widgets/dc_text.dart';
import '../../widgets/dc_inkwell.dart';

/// DCMessageDialog - A flexible message dialog component
///
/// Usage:
/// ```dart
/// DCMessageDialog(
///   title: 'Alert',
///   message: 'This is a message',
///   buttonTitle: 'OK',
/// )
/// ```
class DCMessageDialog extends StatelessWidget {
  const DCMessageDialog({
    super.key,
    this.title,
    required this.message,
    this.buttonTitle = 'Close',
    this.titleColor,
    this.messageColor,
    this.buttonColor,
    this.backgroundColor = DCColors.surface,
    this.borderRadius = DCSpacing.sm,
    this.maxWidth = 320.0,
  });

  final String? title;
  final String message;
  final String buttonTitle;
  final Color? titleColor;
  final Color? messageColor;
  final Color? buttonColor;
  final Color backgroundColor;
  final double borderRadius;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: maxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: DCSpacing.md),
              if (title?.isNotEmpty ?? false) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DCSpacing.md),
                  child: DCText.bold(
                    title!,
                    fontSize: DCFontSize.md,
                    color: titleColor,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: DCSpacing.sm),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: DCSpacing.md),
                child: DCText.regular(
                  message,
                  fontSize: DCFontSize.normal,
                  color: messageColor ?? DCColors.textSecondary,
                  maxLines: 10,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: DCSpacing.lg),
              const Divider(height: 1, thickness: 0.5),
              DCInkWellVariant(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: 0,
                padding: EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  height: 48,
                  alignment: Alignment.center,
                  child: DCText.medium(
                    buttonTitle,
                    color: buttonColor ?? DCColors.primary,
                    fontSize: DCFontSize.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
