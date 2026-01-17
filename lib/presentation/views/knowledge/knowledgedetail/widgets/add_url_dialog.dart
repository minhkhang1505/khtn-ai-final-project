import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/labeled_text_field.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/datasource_viewmodel.dart';
import 'package:provider/provider.dart';

/// Dialog for adding a URL data source
class AddUrlDialog extends StatefulWidget {
  final String knowledgeId;

  const AddUrlDialog({super.key, required this.knowledgeId});

  @override
  State<AddUrlDialog> createState() => _AddUrlDialogState();
}

class _AddUrlDialogState extends State<AddUrlDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Page type: "single" or "site"
  String _pageType = 'single';

  // Auto-reindex settings
  bool _autoReindexEnabled = false;
  int _autoReindexIntervalHours = 24; // Default: 1 day

  // Loading states
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;

  // Reindex interval options (in hours)
  final List<Map<String, dynamic>> _intervalOptions = [
    {'label': '30 min', 'hours': 0.5},
    {'label': '1 hour', 'hours': 1},
    {'label': '6 hours', 'hours': 6},
    {'label': '12 hours', 'hours': 12},
    {'label': '1 day', 'hours': 24},
    {'label': '3 days', 'hours': 72},
    {'label': '1 week', 'hours': 168},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
        _isSuccess = false;
      });

      try {
        final datasourceVm = context.read<DatasourceViewmodel>();

        final success = await datasourceVm.addDatasourceFromWebsiteToKnowledge(
          widget.knowledgeId,
          name: _nameController.text.trim(),
          url: _urlController.text.trim(),
          type: _pageType,
          autoReindexEnabled: _autoReindexEnabled,
          autoReindexIntervalHours: _autoReindexEnabled
              ? _autoReindexIntervalHours
              : null,
        );

        if (!mounted) return;

        if (success) {
          setState(() {
            _isLoading = false;
            _isSuccess = true;
          });

          // Show success state briefly before closing
          await Future.delayed(const Duration(seconds: 1));

          if (!mounted) return;

          // Return success
          Navigator.pop(context, true);
        } else {
          throw Exception('Failed to add URL datasource');
        }
      } catch (e) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
          _isSuccess = false;
          _errorMessage = 'Failed to add URL: ${e.toString()}';
        });
      }
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
        child: Form(
          key: _formKey,
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
                      'Add URL',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // URL field
                LabeledTextField(
                  label: 'URL',
                  hintText: 'https://example.com',
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a URL';
                    }
                    // Basic URL validation
                    final urlPattern = RegExp(
                      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
                    );
                    if (!urlPattern.hasMatch(value.trim())) {
                      return 'Please enter a valid URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Page Type Selection
                _buildPageTypeSection(),
                const SizedBox(height: 24),

                // Auto-Reindex Section
                _buildAutoReindexSection(),
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
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.pop(context),
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
      ),
    );
  }

  Widget _buildPageTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Page Type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment<String>(
              value: 'single',
              label: Text('Single Page'),
              icon: Icon(Icons.article_outlined, size: 18),
            ),
            ButtonSegment<String>(
              value: 'site',
              label: Text('Whole Site'),
              icon: Icon(Icons.language, size: 18),
            ),
          ],
          selected: {_pageType},
          onSelectionChanged: (Set<String> newSelection) {
            setState(() {
              _pageType = newSelection.first;
            });
          },
          style: ButtonStyle(visualDensity: VisualDensity.compact),
        ),
      ],
    );
  }

  Widget _buildAutoReindexSection() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auto Reindex',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Automatically update content periodically',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withAlpha(140),
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _autoReindexEnabled,
              onChanged: (value) {
                setState(() {
                  _autoReindexEnabled = value;
                });
              },
            ),
          ],
        ),
        if (_autoReindexEnabled) ...[
          const SizedBox(height: 16),
          Text(
            'Update Interval',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface.withAlpha(200),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 4,
            runSpacing: 0,
            children: _intervalOptions.map((option) {
              final hours = option['hours'] as num;
              final label = option['label'] as String;
              final isSelected = _autoReindexIntervalHours == hours;

              return FilterChip(
                label: Text(label),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _autoReindexIntervalHours = hours.toInt();
                    });
                  }
                },
                selectedColor: colorScheme.primaryContainer,
                checkmarkColor: colorScheme.primary,
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
