import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class ExpandedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;

  const ExpandedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // Handle button press
          onPressed();
        },
        icon: icon,
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.surfaceContainerHigh,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.medium,
            side: BorderSide(color: colorScheme.outline),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}