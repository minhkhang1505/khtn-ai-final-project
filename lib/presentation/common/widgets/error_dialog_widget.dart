import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String errorMessage;
  final String? title;
  final VoidCallback? onClose;
  final bool showConfirmButton;
  final String confirmText;
  final String closeText;
  final VoidCallback? onConfirm;

  const ErrorDialogWidget({
    super.key,
    required this.errorMessage,
    this.title,
    this.onClose,
    this.showConfirmButton = false,
    this.confirmText = 'Confirm',
    this.closeText = 'OK',
    this.onConfirm,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String errorMessage,
    String? title,
    VoidCallback? onClose,
    bool showConfirmButton = false,
    String confirmText = 'Confirm',
    String closeText = 'OK',
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => ErrorDialogWidget(
        errorMessage: errorMessage,
        title: title,
        onClose: onClose,
        showConfirmButton: showConfirmButton,
        confirmText: confirmText,
        closeText: closeText,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? 'Error',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(errorMessage),
      actions: [
        if (showConfirmButton)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              if (onConfirm != null) onConfirm!();
            },
            child: Text(confirmText, style: const TextStyle(color: Colors.red)),
          ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            if (onClose != null) onClose!();
          },
          child: Text(closeText),
        ),
      ],
    );
  }
}
