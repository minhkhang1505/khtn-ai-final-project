import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_details_section.dart';

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

  void _cancelPrompt() {
    // TODO: Implement cancel logic here
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Prompt Detail')),
      body: SafeArea(
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
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            side: BorderSide(color: colorScheme.outline),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Delete"),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            side: BorderSide(color: colorScheme.outline),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Save",
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
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
}
