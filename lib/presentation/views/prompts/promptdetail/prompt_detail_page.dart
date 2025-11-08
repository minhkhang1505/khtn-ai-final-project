import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_details_section.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/promptdetail/widgets/prompt_detail_action_buttons.dart';

class PromptDetailPage extends StatefulWidget {
  const PromptDetailPage({super.key});

  @override
  State<PromptDetailPage> createState() => _PromptDetailPageState();
}

class _PromptDetailPageState extends State<PromptDetailPage> {
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

  void _deletePromp() {
    // TODO: Implement cancel logic here
  }

  void _backToPromptsList() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Prompt Detail'),
        leading: IconButton(
          onPressed: _backToPromptsList,
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWideScreen ? 800 : double.infinity,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
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
                        SizedBox(height: 16),
                        PromptDetailActionButtons(
                          title: _titleController.text,
                          onSaveChange: _savePrompt,
                          onDelete: _deletePromp,
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
