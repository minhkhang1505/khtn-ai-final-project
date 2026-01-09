import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/labeled_text_field.dart';

/// Dialog for adding a Google Drive data source
class AddDriveDialog extends StatefulWidget {
  const AddDriveDialog({super.key});

  @override
  State<AddDriveDialog> createState() => _AddDriveDialogState();
}

class _AddDriveDialogState extends State<AddDriveDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _promptController = TextEditingController();
  String? _selectedFileId;
  String? _selectedFileName;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _pickDriveFile() async {
    // TODO: Implement Google Drive file picker integration
    // For now, simulate file selection
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _selectedFileId = 'sample_file_id_123';
      _selectedFileName = 'Sample Document.pdf';
      _isLoading = false;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google Drive integration coming soon'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a name'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_selectedFileId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a file from Google Drive'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Return the data
    Navigator.pop(context, {
      'name': _nameController.text.trim(),
      'fileId': _selectedFileId,
      'fileName': _selectedFileName,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add from Google Drive',
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

              // Name field
              LabeledTextField(
                label: 'Name',
                hintText: 'Enter a name for this data source',
                controller: _nameController,
              ),
              const SizedBox(height: 20),

              // Drive file picker area
              const Text(
                'Google Drive File',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _isLoading ? null : _pickDriveFile,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedFileId != null
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant.withAlpha(50),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: _selectedFileId != null
                        ? Theme.of(context).colorScheme.primary.withAlpha(30)
                        : Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(30),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _selectedFileId != null
                                    ? Icons.check_circle
                                    : Icons.cloud_upload,
                                color: _selectedFileId != null
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).colorScheme.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedFileName ??
                                        'Select file from Google Drive',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: _selectedFileId != null
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: _selectedFileId != null
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                  if (_selectedFileId == null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      'Click to browse your Drive',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),

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
                    onPressed: _isLoading ? null : _handleSubmit,
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
      ),
    );
  }
}
