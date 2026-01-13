import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/file_input_section.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/labeled_text_field.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/datasource_viewmodel.dart';
import 'package:provider/provider.dart';

/// Dialog for adding a file data source
class AddFileDialog extends StatefulWidget {
  const AddFileDialog({super.key});

  @override
  State<AddFileDialog> createState() => _AddFileDialogState();
}

class _AddFileDialogState extends State<AddFileDialog> {
  final TextEditingController _promptController = TextEditingController();
  List<PlatformFile> _selectedFiles = [];
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {

    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one file'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _isSuccess = false;
    });

    try {
      final datasourceVm = context.read<DatasourceViewmodel>();

      final uploadedUrl = await datasourceVm.uploadFiles(_selectedFiles);

      if (!mounted) return;

      if (uploadedUrl.isNotEmpty) {
        setState(() {
          _isLoading = false;
          _isSuccess = true;
        });

        // Show success state briefly before closing
        await Future.delayed(const Duration(seconds: 1));

        if (!mounted) return;

        // Return the uploaded URL and prompt
        Navigator.pop(context, {
          'url': uploadedUrl,
          'prompt': _promptController.text.trim(),
        });
      } else {
        throw Exception('Upload failed: empty URL returned');
      }
    } catch (e) {

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _isSuccess = false;
        _errorMessage = 'Failed to upload files: ${e.toString()}';
      });
    }
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
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
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

              // Error message
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 100),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.3),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 11,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            _handleSubmit();
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : _isSuccess
                        ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, size: 20),
                              SizedBox(width: 4),
                              Text('Success'),
                            ],
                          )
                        : const Text('Add'),
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
