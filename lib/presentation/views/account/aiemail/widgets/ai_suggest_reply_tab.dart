import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_request_entity.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/custom_text_form_field.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/save_action_button_row.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/aiemail/ai_email_viewmodel.dart';

class AiSuggestReplyTab extends StatefulWidget {
  final AiEmailViewmodel viewModel;
  final bool isLoading;
  final VoidCallback onSubmitStart;

  const AiSuggestReplyTab({
    super.key,
    required this.viewModel,
    required this.isLoading,
    required this.onSubmitStart,
  });

  @override
  State<AiSuggestReplyTab> createState() => _AiSuggestReplyTabState();
}

class _AiSuggestReplyTabState extends State<AiSuggestReplyTab> {
  final _formKey = GlobalKey<FormState>();

  final _suggestActionController = TextEditingController();
  final _suggestEmailController = TextEditingController();
  final _suggestSubjectController = TextEditingController();
  final _suggestSenderController = TextEditingController();
  final _suggestReceiverController = TextEditingController();
  final _suggestLanguageController = TextEditingController();

  SuggestAssistantModelId? _selectedSuggestAssistantModel =
      SuggestAssistantModelId.gemini15FlashLatest;

  final List<_SuggestContextItem> _suggestContexts = [_SuggestContextItem()];

  @override
  void dispose() {
    _suggestActionController.dispose();
    _suggestEmailController.dispose();
    _suggestSubjectController.dispose();
    _suggestSenderController.dispose();
    _suggestReceiverController.dispose();
    _suggestLanguageController.dispose();
    for (final contextItem in _suggestContexts) {
      contextItem.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSuggestReplyIdeas() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSubmitStart();

    final contextItems = _suggestContexts
        .map(
          (item) => SuggestEmailContentEntity(
            subject: item.subjectController.text.trim(),
            sender: item.senderController.text.trim(),
            receiver: item.receiverController.text.trim(),
            content: item.contentController.text.trim(),
          ),
        )
        .toList();

    final request = SuggestReplyIdeaRequestEntity(
      action: _suggestActionController.text.trim(),
      email: _suggestEmailController.text.trim(),
      assistant: _selectedSuggestAssistantModel != null
          ? SuggestAssistantEntity(
              id: _selectedSuggestAssistantModel,
              model: SuggestAssistantModel.dify,
            )
          : null,
      metadata: SuggestReplyMetadataEntity(
        context: contextItems,
        subject: _suggestSubjectController.text.trim(),
        sender: _suggestSenderController.text.trim(),
        receiver: _suggestReceiverController.text.trim(),
        language: _suggestLanguageController.text.trim(),
      ),
    );

    await widget.viewModel.generateReplyIdeas(request);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Action'),
            CustomTextFormField(
              controller: _suggestActionController,
              hintText: 'e.g., Reply to this email',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the action';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Email'),
            CustomTextFormField(
              controller: _suggestEmailController,
              hintText: 'Email address',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the email';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Metadata'),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: _suggestSubjectController,
              hintText: 'Subject',
              prefixIcon: Icons.subject,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the subject';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: _suggestSenderController,
              hintText: 'Sender',
              prefixIcon: Icons.person,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the sender';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: _suggestReceiverController,
              hintText: 'Receiver',
              prefixIcon: Icons.email,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the receiver';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: _suggestLanguageController,
              hintText: 'Language',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the language';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Context'),
            const SizedBox(height: 12),
            ..._suggestContexts.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _buildContextItem(item, index);
            }),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _suggestContexts.add(_SuggestContextItem());
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Context'),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('AI Assistant (Optional)'),
            const SizedBox(height: 12),
            _buildSuggestAssistantModelDropdown(),
            const SizedBox(height: 32),
            SaveActionButtonRow(
              rightButtonLabel: 'Generate Ideas',
              leftButtonLabel: 'Clear',
              onRightButtonPress: widget.isLoading
                  ? null
                  : _handleSuggestReplyIdeas,
              onLeftButtonPress: () {
                _suggestActionController.clear();
                _suggestEmailController.clear();
                _suggestSubjectController.clear();
                _suggestSenderController.clear();
                _suggestReceiverController.clear();
                _suggestLanguageController.clear();
                for (final contextItem in _suggestContexts) {
                  contextItem.clear();
                }
                setState(() {
                  _selectedSuggestAssistantModel = null;
                });
              },
              isDisabled: widget.isLoading,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildContextItem(_SuggestContextItem item, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: AppBorderRadius.medium,
        border: Border.all(color: colorScheme.outlineVariant.withAlpha(120)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Context ${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (_suggestContexts.length > 1)
                IconButton(
                  onPressed: () {
                    setState(() {
                      final removed = _suggestContexts.removeAt(index);
                      removed.dispose();
                    });
                  },
                  icon: const Icon(Icons.close, size: 18),
                ),
            ],
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            controller: item.subjectController,
            hintText: 'Subject',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter the subject';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            controller: item.senderController,
            hintText: 'Sender',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter the sender';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            controller: item.receiverController,
            hintText: 'Receiver',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter the receiver';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            controller: item.contentController,
            hintText: 'Content',
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter the content';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildSuggestAssistantModelDropdown() {
    final colorScheme = Theme.of(context).colorScheme;
    final models = [
      {'value': null, 'label': 'Default (Auto-select)'},
      {
        'value': SuggestAssistantModelId.claude3Haiku20240307,
        'label': 'Claude 3 Haiku',
      },
      {
        'value': SuggestAssistantModelId.claude3Sonnet20240229,
        'label': 'Claude 3 Sonnet',
      },
      {
        'value': SuggestAssistantModelId.gemini15FlashLatest,
        'label': 'Gemini 1.5 Flash',
      },
      {
        'value': SuggestAssistantModelId.gemini15ProLatest,
        'label': 'Gemini 1.5 Pro',
      },
      {'value': SuggestAssistantModelId.gpt4O, 'label': 'GPT-4o'},
      {'value': SuggestAssistantModelId.gpt4OMini, 'label': 'GPT-4o Mini'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI Model',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh.withAlpha(120),
            borderRadius: AppBorderRadius.medium,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SuggestAssistantModelId?>(
              value: _selectedSuggestAssistantModel,
              isExpanded: true,
              items: models.map((model) {
                return DropdownMenuItem<SuggestAssistantModelId?>(
                  value: model['value'] as SuggestAssistantModelId?,
                  child: Text(
                    model['label'] as String,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedSuggestAssistantModel = value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SuggestContextItem {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController senderController = TextEditingController();
  final TextEditingController receiverController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void clear() {
    subjectController.clear();
    senderController.clear();
    receiverController.clear();
    contentController.clear();
  }

  void dispose() {
    subjectController.dispose();
    senderController.dispose();
    receiverController.dispose();
    contentController.dispose();
  }
}
