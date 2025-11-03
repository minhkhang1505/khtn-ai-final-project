import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_back_button.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_details_section.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_preview_section.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_action_buttons.dart';

class CreateNewPromptPage extends StatefulWidget {
  const CreateNewPromptPage({super.key});

  @override
  State<CreateNewPromptPage> createState() => _CreateNewPromptPageState();
}

class _CreateNewPromptPageState extends State<CreateNewPromptPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();

  String? _selectedCategory;
  String? _selectedLanguage;
  bool _isPublic = true;

  @override
  void initState() {
    super.initState();
    // Listen to changes for live preview
    _titleController.addListener(_updatePreview);
    _contentController.addListener(_updatePreview);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _updatePreview() {
    setState(() {});
  }

  void _savePrompt() {
    // TODO: Implement save logic here
  }

  void _cancelPrompt() {
    // TODO: Implement cancel logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("New Prompt"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWideScreen ? 800 : double.infinity,
              ),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        PromptDetailsSection(
                          titleController: _titleController,
                          descriptionController: _descriptionController,
                          contentController: _contentController,
                          selectedCategory: _selectedCategory,
                          selectedLanguage: _selectedLanguage,
                          isPublic: _isPublic,
                          onCategoryChanged: (value) {
                            setState(() => _selectedCategory = value);
                          },
                          onLanguageChanged: (value) {
                            setState(() => _selectedLanguage = value);
                          },
                          onPublicChanged: (value) {
                            setState(() => _isPublic = value);
                          },
                        ),
                        const SizedBox(height: 12),
                        PromptPreviewSection(
                          title: _titleController.text,
                          content: _contentController.text,
                        ),
                        const SizedBox(height: 12),
                        PromptActionButtons(
                          onCancel: _cancelPrompt,
                          onSave: _savePrompt,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
