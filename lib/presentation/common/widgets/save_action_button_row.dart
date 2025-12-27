import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class SaveActionButtonRow extends StatelessWidget {
  final VoidCallback? onRightButtonPress;
  final VoidCallback? onLeftButtonPress;
  final bool isDisabled;
  final String leftButtonLabel;
  final String rightButtonLabel;

  const SaveActionButtonRow({
    super.key,
    this.onRightButtonPress,
    this.onLeftButtonPress,
    this.isDisabled = false,
    this.leftButtonLabel = 'Cancel',
    this.rightButtonLabel = 'Save Changes',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed:
                onLeftButtonPress ??
                () {
                  Navigator.pop(context);
                },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.medium,
              ),
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
            child: Text(
              leftButtonLabel,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (onRightButtonPress != null) {
                onRightButtonPress!();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              disabledBackgroundColor: colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.medium,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
            child: Text(
              rightButtonLabel,
              style: TextStyle(
                color: isDisabled
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
