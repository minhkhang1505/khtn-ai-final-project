import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/domain/entities/email_request_entity.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_text_form_field.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/save_action_button_row.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/error_dialog_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/aiemail/ai_email_viewmodel.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class AIResponseEmailPage extends StatefulWidget {
  const AIResponseEmailPage({super.key});

  @override
  State<AIResponseEmailPage> createState() => _AIResponseEmailPageState();
}

class _AIResponseEmailPageState extends State<AIResponseEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _aiEmailViewModel = sl<AiEmailViewmodel>();

  // Text controllers
  final _mainIdeaController = TextEditingController();
  final _actionController = TextEditingController(text: 'Reply to this email');
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _senderController = TextEditingController();
  final _receiverController = TextEditingController();

  // Style options
  String _selectedLength = 'long';
  String _selectedFormality = 'neutral';
  String _selectedTone = 'friendly';
  String _selectedLanguage = 'vietnamese';

  // AI Assistant model selection (optional)
  AssistantModelId? _selectedAssistantModel;

  @override
  void initState() {
    super.initState();
    _aiEmailViewModel.addListener(_handleViewModelChange);
  }

  @override
  void dispose() {
    _aiEmailViewModel.removeListener(_handleViewModelChange);
    _mainIdeaController.dispose();
    _actionController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _senderController.dispose();
    _receiverController.dispose();
    super.dispose();
  }

  void _handleViewModelChange() {
    if (_aiEmailViewModel.state == AiEmailState.success) {
      _showSuccessDialog();
    } else if (_aiEmailViewModel.state == AiEmailState.failure) {
      _showErrorDialog();
    }
  }

  void _showSuccessDialog() {
    final response = _aiEmailViewModel.response;
    if (response != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Email Generated Successfully'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(response.email, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 16),
                Text(
                  'Remaining usage: ${response.remainingUsage}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  void _showErrorDialog() {
    ErrorDialogWidget.show(
      context,
      errorMessage:
          _aiEmailViewModel.errorMessage ?? 'Failed to generate email response',
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

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
        language: _selectedLanguage,
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

    await _aiEmailViewModel.generateEmailResponse(request);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = _aiEmailViewModel.state == AiEmailState.loading;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: const Text('AI Email Response'),
      ),
      body: Stack(
        children: [
          Form(
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
                  _buildStyleDropdown(
                    'Tone',
                    _selectedTone,
                    ['friendly', 'professional', 'enthusiastic', 'empathetic'],
                    (value) => setState(() => _selectedTone = value),
                  ),
                  const SizedBox(height: 12),
                  _buildStyleDropdown(
                    'Language',
                    _selectedLanguage,
                    ['vietnamese', 'english'],
                    (value) => setState(() => _selectedLanguage = value),
                  ),
                  const SizedBox(height: 32),
                  SaveActionButtonRow(
                    rightButtonLabel: 'Generate Email',
                    leftButtonLabel: 'Clear',
                    onRightButtonPress: isLoading ? null : _handleSubmit,
                    onLeftButtonPress: () {
                      _mainIdeaController.clear();
                      _emailController.clear();
                      _subjectController.clear();
                      _senderController.clear();
                      _receiverController.clear();
                      setState(() {
                        _selectedLength = 'long';
                        _selectedFormality = 'neutral';
                        _selectedTone = 'friendly';
                        _selectedLanguage = 'vietnamese';
                        _selectedAssistantModel = null;
                      });
                    },
                    isDisabled: isLoading,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const LoadingIndicatorWidget(),
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
