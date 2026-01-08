import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt/create_prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_details_section.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_preview_section.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_action_buttons.dart';

class CreateNewPromptPage extends StatelessWidget {
  const CreateNewPromptPage({super.key});

  void _savePrompt(
    BuildContext context,
    CreatePromptViewModel viewModel,
  ) async {
    final success = await viewModel.savePrompt();
    if (context.mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prompt created successfully')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(viewModel.errorMessage ?? 'Failed to create prompt'),
          ),
        );
      }
    }
  }

  void _cancelPrompt(BuildContext context, CreatePromptViewModel viewModel) {
    viewModel.clearForm();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePromptViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
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
              return Align(
                alignment: Alignment.topCenter,
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
                              titleController: viewModel.titleController,
                              descriptionController:
                                  viewModel.descriptionController,
                              contentController: viewModel.contentController,
                              selectedCategory: viewModel.selectedCategory,
                              selectedLanguage: viewModel.selectedLanguage,
                              isPublic: viewModel.isPublic,
                              onCategoryChanged: (value) {
                                if (value != null) viewModel.setCategory(value);
                              },
                              onLanguageChanged: (value) {
                                if (value != null) viewModel.setLanguage(value);
                              },
                              onPublicChanged: viewModel.setIsPublic,
                            ),
                            const SizedBox(height: 12),
                            PromptPreviewSection(
                              title: viewModel.titleController.text,
                              content: viewModel.contentController.text,
                            ),
                            const SizedBox(height: 12),
                            PromptActionButtons(
                              onCancel: () => _cancelPrompt(context, viewModel),
                              onSave: viewModel.isLoading
                                  ? () {}
                                  : () => _savePrompt(context, viewModel),
                            ),
                            if (viewModel.isLoading)
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
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
      },
    );
  }
}
