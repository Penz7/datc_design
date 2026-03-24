import 'package:flutter/material.dart';
import '../constants/index.dart';
import 'view/dc_confirm_dialog.dart';
import 'view/dc_message_dialog.dart';
import 'view/dc_custom_dialog.dart';

/// DCDialogProvider - Singleton provider to manage and show dialogs
class DCDialogProvider {
  static final DCDialogProvider instance = DCDialogProvider._();

  DCDialogProvider._();

  /// Flag to prevent multiple dialogs if needed (optional implementation logic)
  static bool isShowingMessage = false;

  /// Shows a flexible message dialog
  Future<void> showMessageDialog(
    BuildContext context, {
    String? title,
    required String message,
    String buttonTitle = 'Close',
    Color? buttonColor,
    bool barrierDismissible = false,
  }) async {
    if (isShowingMessage) return;
    isShowingMessage = true;

    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => DCMessageDialog(
        title: title,
        message: message,
        buttonTitle: buttonTitle,
        buttonColor: buttonColor,
      ),
    );

    isShowingMessage = false;
  }

  /// Shows a flexible confirmation dialog
  /// Returns `true` if confirmed, `false` otherwise.
  Future<bool> showConfirmDialog(
    BuildContext context, {
    String? title,
    required String message,
    String confirmTitle = 'Confirm',
    String cancelTitle = 'Cancel',
    Color? confirmColor,
    Color? cancelColor,
    bool barrierDismissible = false,
  }) async {
    final result = await showDialog<bool?>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => DCConfirmDialog(
        title: title,
        message: message,
        confirmTitle: confirmTitle,
        cancelTitle: cancelTitle,
        confirmColor: confirmColor,
        cancelColor: cancelColor,
      ),
    );

    return result ?? false;
  }

  /// Shows a custom dialog with absolute freedom for child and styling.
  Future<T?> showCustomDialog<T>(
    BuildContext context, {
    required Widget child,
    Color backgroundColor = DCColors.surface,
    double borderRadius = DCSpacing.md,
    EdgeInsetsGeometry padding = const EdgeInsets.all(DCSpacing.md),
    double maxWidth = 320.0,
    bool barrierDismissible = true,
  }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => DCCustomDialog(
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        padding: padding,
        maxWidth: maxWidth,
        barrierDismissible: barrierDismissible,
        child: child,
      ),
    );
  }
}
