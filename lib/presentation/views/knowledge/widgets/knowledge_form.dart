import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/models/knowledge_source_type.dart';
import 'package:khtn_ai_final_project/core/constants/knowledge_constants.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/error_dialog_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/save_action_button_row.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/knowledge_detail_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/file_input_section.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_form_card.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_section_header.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_source_dropdown.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/labeled_text_field.dart';
import 'package:provider/provider.dart';

/// A reusable form widget for creating/editing knowledge sources
class KnowledgeForm extends StatefulWidget {
  final String? initialSourceName;
  final String? initialSourceDescription;
  final String? initialUrl;
  final KnowledgeSourceType? initialSourceType;
  final bool isEditMode;
  final VoidCallback? onEditPressed;
  final void Function({
    required String sourceName,
    required String sourceDescription,
    required String url,
    required KnowledgeSourceType sourceType,
  })?
  onSave;

  const KnowledgeForm({
    super.key,
    this.initialSourceName,
    this.initialSourceDescription,
    this.initialUrl,
    this.initialSourceType,
    this.isEditMode = false,
    this.onEditPressed,
    this.onSave,
  });

  @override
  State<KnowledgeForm> createState() => _KnowledgeFormState();
}

class _KnowledgeFormState extends State<KnowledgeForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _sourceTypeController;
  late final TextEditingController _sourceNameController;
  late final TextEditingController _sourceDescriptionController;
  late final TextEditingController _urlController;
  late KnowledgeSourceType _selectedSourceType;
  late KnowledgeSourceType _initialSourceType;
  late String _initialSourceName;
  late String _initialSourceDescription;
  late String _initialUrl;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _selectedSourceType =
        widget.initialSourceType ?? KnowledgeSourceTypes.all[0];
    _initialSourceType = _selectedSourceType;
    _initialSourceName = widget.initialSourceName ?? '';
    _initialSourceDescription = widget.initialSourceDescription ?? '';
    _initialUrl = widget.initialUrl ?? '';

    _sourceTypeController = TextEditingController(
      text: _selectedSourceType.name,
    );
    _sourceNameController = TextEditingController(
      text: widget.initialSourceName,
    );
    _sourceDescriptionController = TextEditingController(
      text: widget.initialSourceDescription,
    );
    _urlController = TextEditingController(text: widget.initialUrl);

    // Add listeners to track changes
    _sourceNameController.addListener(_checkForChanges);
    _sourceDescriptionController.addListener(_checkForChanges);
    _urlController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    _sourceTypeController.dispose();
    _sourceNameController.dispose();
    _sourceDescriptionController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          KnowledgeFormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KnowledgeSectionHeader(
                  title: KnowledgeConstants.addDataSourceTitle,
                  onActionPressed: widget.onEditPressed,
                  actionIconPath: widget.onEditPressed != null
                      ? 'assets/icons/ic_edit.svg'
                      : null,
                ),
                const SizedBox(height: 24),
                KnowledgeSourceDropdown(
                  controller: _sourceTypeController,
                  initialSelection: _selectedSourceType,
                  enabled: widget.isEditMode,
                  onSelected: (KnowledgeSourceType? source) {
                    if (source != null) {
                      setState(() {
                        _selectedSourceType = source;
                        _sourceTypeController.text = source.name;
                      });

                      _checkForChanges();
                    }
                  },
                ),
                const SizedBox(height: 16),

                LabeledTextField(
                  label: KnowledgeConstants.sourceNameLabel,
                  hintText: KnowledgeConstants.sourceNameHint,
                  controller: _sourceNameController,
                  validator: _validateSourceName,
                  readOnly: !widget.isEditMode,
                ),
                const SizedBox(height: 16),
                LabeledTextField(
                  label: KnowledgeConstants.sourceDescriptionLabel,
                  hintText: KnowledgeConstants.sourceDescriptionHint,
                  controller: _sourceDescriptionController,
                  minLines: 4,
                  maxLines: null,
                  readOnly: !widget.isEditMode,
                ),
                const SizedBox(height: 16),
                LabeledTextField(
                  label: KnowledgeConstants.urlOrPathLabel,
                  hintText: KnowledgeConstants.urlOrPathHint,
                  controller: _urlController,
                  validator: _validateUrl,
                  keyboardType: TextInputType.url,
                  readOnly: !widget.isEditMode,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_selectedSourceType == KnowledgeSourceTypes.file)
            FileInputSection(
              onFilePicked: (file) {
                if (file != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đã chọn file: ${file.name}')),
                  );
                }
              },
            ),
          SaveActionButtonRow(
            onRightButtonPress: (widget.isEditMode && _hasChanges)
                ? _handleSave
                : null,
            onLeftButtonPress: () {
              ErrorDialogWidget.show(
                context,
                title: 'Delete Data Source',
                errorMessage:
                    'Are you sure you want to delete this data source?',
                showConfirmButton: true,
                confirmText: 'Delete',
                onConfirm: _handleDelete,
                onClose: () => Navigator.pop(context),
              );
            },
            isDisabled: (widget.isEditMode && _hasChanges),
            leftButtonLabel: "Delete",
            rightButtonLabel: "Save",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ElevatedButton(
              //   onPressed: (widget.isEditMode && _hasChanges)
              //       ? _handleSave
              //       : null,
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: colorScheme.primary,
              //     disabledBackgroundColor: colorScheme.surfaceContainerHighest,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: AppBorderRadius.medium,
              //     ),
              //   ),
              //   child: Text(
              //     KnowledgeConstants.saveButton,
              //     style: TextStyle(
              //       color: (widget.isEditMode && _hasChanges)
              //           ? colorScheme.onPrimary
              //           : colorScheme.onSurfaceVariant,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  void _checkForChanges() {
    final hasChanges =
        _sourceNameController.text != _initialSourceName ||
        _sourceDescriptionController.text != _initialSourceDescription ||
        _urlController.text != _initialUrl ||
        _selectedSourceType != _initialSourceType;

    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave?.call(
        sourceName: _sourceNameController.text,
        sourceDescription: _sourceDescriptionController.text,
        url: _urlController.text,
        sourceType: _selectedSourceType,
      );
    }

    context.read<KnowledgeDetailViewmodel>().updateKnowledge();

    if (!context.mounted) return;
  }

  String? _validateSourceName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return KnowledgeConstants.sourceNameRequired;
    }
    return null;
  }

  String? _validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return KnowledgeConstants.urlRequired;
    }
    // Basic URL validation
    final urlPattern = r'^https?://';
    if (!RegExp(urlPattern).hasMatch(value)) {
      return KnowledgeConstants.invalidUrl;
    }
    return null;
  }

  Future<void> _handleDelete() async {
    final vm = context.read<KnowledgeDetailViewmodel>();
    final success = await vm.deleteKnowledge();

    if (!mounted) return;

    if (success) {
      _backToKnowledgeBaseList();
    }
  }

  void _backToKnowledgeBaseList() {
    if (!mounted) return;

    context.read<KnowledgeDetailViewmodel>().clearItem();
    Navigator.pop(context, true); // Return true to indicate success
  }
}
