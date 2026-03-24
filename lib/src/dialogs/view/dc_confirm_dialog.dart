import 'package:flutter/material.dart';
import '../../constants/index.dart';
import '../../widgets/dc_text.dart';
import '../../widgets/dc_inkwell.dart';

/// DCConfirmDialog - A flexible confirmation dialog component
///
/// Usage:
/// ```dart
/// DCConfirmDialog(
///   title: 'Confirm',
///   message: 'Do you want to proceed?',
/// )
/// ```
class DCConfirmDialog extends StatelessWidget {
  const DCConfirmDialog({
    super.key,
    this.title,
    required this.message,
    this.confirmTitle = 'Confirm',
    this.cancelTitle = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.confirmColor,
    this.cancelColor,
    this.backgroundColor = DCColors.surface,
    this.borderRadius = DCSpacing.sm,
    this.maxWidth = 320.0,
  });

  final String? title;
  final String message;
  final String confirmTitle;
  final String cancelTitle;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmColor;
  final Color? cancelColor;
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
                  color: DCColors.textSecondary,
                  maxLines: 10,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: DCSpacing.lg),
              const Divider(height: 1, thickness: 0.5),
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      child: DCInkWellVariant(
                        onTap: () {
                          onCancel?.call();
                          Navigator.of(context).pop(false);
                        },
                        borderRadius: 0,
                        padding: EdgeInsets.zero,
                        child: Center(
                          child: DCText.medium(
                            cancelTitle,
                            color: cancelColor ?? DCColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 1, thickness: 0.5),
                    Expanded(
                      child: DCInkWellVariant(
                        onTap: () {
                          onConfirm?.call();
                          Navigator.of(context).pop(true);
                        },
                        borderRadius: 0,
                        padding: EdgeInsets.zero,
                        child: Center(
                          child: DCText.medium(
                            confirmTitle,
                            color: confirmColor ?? DCColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
