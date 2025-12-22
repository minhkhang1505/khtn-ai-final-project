import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class SaveActionButtonRow extends StatelessWidget {
  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  const SaveActionButtonRow({super.key, this.onSave, this.onCancel});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.medium,
              ),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (onSave != null) {
                onSave!();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.medium,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
            ),
            child: Text(
              'Save Changes',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}