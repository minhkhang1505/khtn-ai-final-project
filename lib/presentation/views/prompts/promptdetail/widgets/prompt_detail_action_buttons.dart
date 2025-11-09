import 'package:flutter/material.dart';

class PromptDetailActionButtons extends StatelessWidget {
  final String title;
  final VoidCallback onSaveChange;
  final VoidCallback onDelete;

  const PromptDetailActionButtons({
    super.key,
    required this.title,
    required this.onSaveChange,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
                side: BorderSide(color: colorScheme.outline),
              ),
            ),
            onPressed: onDelete,
            child: const Text("Delete"),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
                side: BorderSide(color: colorScheme.outline),
              ),
            ),
            onPressed: onSaveChange,
            child: Text(
              "Save Change",
              style: TextStyle(color: colorScheme.onPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
