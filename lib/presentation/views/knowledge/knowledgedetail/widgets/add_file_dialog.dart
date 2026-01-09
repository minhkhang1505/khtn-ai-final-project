import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/file_input_section.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/labeled_text_field.dart';

/// Dialog for adding a file data source
class AddFileDialog extends StatefulWidget {
  const AddFileDialog({super.key});

  @override
  State<AddFileDialog> createState() => _AddFileDialogState();
}

class _AddFileDialogState extends State<AddFileDialog> {
  final TextEditingController _promptController = TextEditingController();
  List<PlatformFile> _selectedFiles = [];

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one file'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Return the selected files and prompt
    Navigator.pop(context, {
      'files': _selectedFiles,
      'prompt': _promptController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add File',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            FileInputSection(
              initialFiles: _selectedFiles,
              onFilesPicked: (files) {
                setState(() {
                  _selectedFiles = files;
                });
              },
            ),
            const SizedBox(height: 24),

            // Prompt text field
            LabeledTextField(
              label: 'Prompt (Optional)',
              hintText: 'Enter any specific instructions or context...',
              controller: _promptController,
              minLines: 3,
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
