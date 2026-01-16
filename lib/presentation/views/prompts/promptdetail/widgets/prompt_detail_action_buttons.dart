import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/error_dialog_widget.dart';

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

  void onDeleteButtonPressed(BuildContext context) {
    ErrorDialogWidget.show(
      context,
      title: 'Confirm Deletion',
      errorMessage: 'Are you sure you want to delete this prompt?',
      onClose: () {},
      showConfirmButton: true,
      confirmText: 'Delete',
      onConfirm: onDelete,
      closeText: 'Cancel',
    );
  }

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
            onPressed: () => onDeleteButtonPressed(context),
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
