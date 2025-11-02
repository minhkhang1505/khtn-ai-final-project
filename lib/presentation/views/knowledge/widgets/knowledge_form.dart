import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/domain/models/knowledge_source_type.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/constants/knowledge_constants.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_form_card.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_section_header.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_source_dropdown.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/labeled_text_field.dart';

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
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    _selectedSourceType =
        widget.initialSourceType ?? KnowledgeSourceTypes.all[0];
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
  }

  @override
  void dispose() {
    _sourceTypeController.dispose();
    _sourceNameController.dispose();
    _sourceDescriptionController.dispose();
    _urlController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                  onActionPressed: widget.isEditMode
                      ? widget.onEditPressed
                      : null,
                  actionIconPath: widget.isEditMode
                      ? 'assets/icons/ic_edit.svg'
                      : null,
                ),
                const SizedBox(height: 24),
                KnowledgeSourceDropdown(
                  controller: _sourceTypeController,
                  initialSelection: _selectedSourceType,
                  onSelected: (KnowledgeSourceType? source) {
                    if (source != null) {
                      setState(() {
                        _selectedSourceType = source;
                        _sourceTypeController.text = source.name;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                LabeledTextField(
                  label: KnowledgeConstants.sourceNameLabel,
                  hintText: KnowledgeConstants.sourceNameHint,
                  controller: _sourceNameController,
                  validator: _validateSourceName,
                  readOnly: isEditMode,
                ),
                const SizedBox(height: 16),
                LabeledTextField(
                  label: KnowledgeConstants.sourceDescriptionLabel,
                  hintText: KnowledgeConstants.sourceDescriptionHint,
                  controller: _sourceDescriptionController,
                  minLines: 4,
                  maxLines: null,
                  readOnly: isEditMode,
                ),
                const SizedBox(height: 16),
                LabeledTextField(
                  label: KnowledgeConstants.urlOrPathLabel,
                  hintText: KnowledgeConstants.urlOrPathHint,
                  controller: _urlController,
                  validator: _validateUrl,
                  keyboardType: TextInputType.url,
                  readOnly: isEditMode,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                  ),
                ),
                child: Text(
                  KnowledgeConstants.saveButton,
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
