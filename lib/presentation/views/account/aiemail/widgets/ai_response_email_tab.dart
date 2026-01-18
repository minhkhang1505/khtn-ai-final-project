import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/email_request_entity.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/custom_text_form_field.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/save_action_button_row.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/aiemail/ai_email_viewmodel.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class AiResponseEmailTab extends StatefulWidget {
  final AiEmailViewmodel viewModel;
  final bool isLoading;
  final VoidCallback onSubmitStart;

  const AiResponseEmailTab({
    super.key,
    required this.viewModel,
    required this.isLoading,
    required this.onSubmitStart,
  });

  @override
  State<AiResponseEmailTab> createState() => _AiResponseEmailTabState();
}

class _AiResponseEmailTabState extends State<AiResponseEmailTab> {
  final _formKey = GlobalKey<FormState>();

  final _mainIdeaController = TextEditingController();
  final _actionController = TextEditingController(text: 'Reply to this email');
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _senderController = TextEditingController();
  final _receiverController = TextEditingController();
  final _languageController = TextEditingController();

  String _selectedLength = 'long';
  String _selectedFormality = 'neutral';
  String _selectedTone = 'friendly';

  AssistantModelId? _selectedAssistantModel;

  @override
  void dispose() {
    _mainIdeaController.dispose();
    _actionController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _senderController.dispose();
    _receiverController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSubmitStart();

    final request = EmailRequestEntity(
      mainIdea: _mainIdeaController.text.trim(),
      action: _actionController.text.trim(),
      email: _emailController.text.trim(),
      assistant: _selectedAssistantModel != null
          ? AssistantEntity(
              id: _selectedAssistantModel,
              model: AssistantModel.dify,
            )
          : null,
      metadata: EmailMetadataEntity(
        context: [
          EmailContentEntity(
            content: _emailController.text.trim(),
            receiver: _receiverController.text.trim(),
            sender: _senderController.text.trim(),
            subject: _subjectController.text.trim(),
          ),
        ],
        language: _languageController.text.trim(),
        receiver: _receiverController.text.trim(),
        sender: _senderController.text.trim(),
        subject: _subjectController.text.trim(),
        style: EmailStyleEntity(
          formality: _selectedFormality,
          length: _selectedLength,
          tone: _selectedTone,
        ),
      ),
    );

    await widget.viewModel.generateEmailResponse(request);
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
            _buildSectionTitle('Main Idea'),
            CustomTextFormField(
              controller: _mainIdeaController,
              hintText: 'Enter your main idea or key points...',
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the main idea';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Action'),
            CustomTextFormField(
              controller: _actionController,
              hintText: 'e.g., Reply to this email',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the action';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Original Email'),
            CustomTextFormField(
              controller: _emailController,
              hintText: 'Paste the original email content here...',
              maxLines: 8,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the email content';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Email Metadata'),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: _subjectController,
              hintText: 'Email subject',
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
              controller: _senderController,
              hintText: 'Sender name or email',
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
              controller: _receiverController,
              hintText: 'Receiver email',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the receiver';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('AI Assistant (Optional)'),
            const SizedBox(height: 12),
            _buildAssistantModelDropdown(),
            const SizedBox(height: 24),
            _buildSectionTitle('Email Style'),
            const SizedBox(height: 12),
            _buildStyleDropdown(
              'Length',
              _selectedLength,
              ['short', 'medium', 'long'],
              (value) => setState(() => _selectedLength = value),
            ),
            const SizedBox(height: 12),
            _buildStyleDropdown(
              'Formality',
              _selectedFormality,
              ['casual', 'neutral', 'formal'],
              (value) => setState(() => _selectedFormality = value),
            ),
            const SizedBox(height: 12),
            _buildStyleDropdown('Tone', _selectedTone, [
              'friendly',
              'professional',
              'enthusiastic',
              'empathetic',
            ], (value) => setState(() => _selectedTone = value)),
            const SizedBox(height: 20),
            _buildSectionTitle('Language'),
            CustomTextFormField(
              controller: _languageController,
              hintText: 'e.g., language',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the language';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            SaveActionButtonRow(
              rightButtonLabel: 'Generate Email',
              leftButtonLabel: 'Clear',
              onRightButtonPress: widget.isLoading ? null : _handleSubmit,
              onLeftButtonPress: () {
                _mainIdeaController.clear();
                _emailController.clear();
                _subjectController.clear();
                _senderController.clear();
                _receiverController.clear();
                _languageController.clear();
                setState(() {
                  _selectedLength = 'long';
                  _selectedFormality = 'neutral';
                  _selectedTone = 'friendly';
                  _selectedAssistantModel = null;
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

  Widget _buildAssistantModelDropdown() {
    final colorScheme = Theme.of(context).colorScheme;
    final models = [
      {'value': null, 'label': 'Default (Auto-select)'},
      {
        'value': AssistantModelId.claude3Haiku20240307,
        'label': 'Claude 3 Haiku',
      },
      {
        'value': AssistantModelId.claude3Sonnet20240229,
        'label': 'Claude 3 Sonnet',
      },
      {
        'value': AssistantModelId.gemini15FlashLatest,
        'label': 'Gemini 1.5 Flash',
      },
      {'value': AssistantModelId.gemini15ProLatest, 'label': 'Gemini 1.5 Pro'},
      {'value': AssistantModelId.gpt4O, 'label': 'GPT-4o'},
      {'value': AssistantModelId.gpt4OMini, 'label': 'GPT-4o Mini'},
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
            child: DropdownButton<AssistantModelId?>(
              value: _selectedAssistantModel,
              isExpanded: true,
              items: models.map((model) {
                return DropdownMenuItem<AssistantModelId?>(
                  value: model['value'] as AssistantModelId?,
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
                setState(() => _selectedAssistantModel = value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStyleDropdown(
    String label,
    String currentValue,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
            child: DropdownButton<String>(
              value: currentValue,
              isExpanded: true,
              items: options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option[0].toUpperCase() + option.substring(1),
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) onChanged(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
