import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class PromptActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String cancelText;
  final String saveText;

  const PromptActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
    this.cancelText = "Cancel",
    this.saveText = "Create",
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.large,
              ),
            ),
            child: Text(cancelText, style: const TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.large,
              ),
              backgroundColor: colorScheme.primary,
            ),
            child: Text(
              saveText,
              style: TextStyle(fontSize: 16, color: colorScheme.onPrimary),
            ),
          ),
        ),
      ],
    );
  }
}