import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt_detail_view_model.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_details_section.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/promptdetail/widgets/prompt_detail_action_buttons.dart';
import 'package:provider/provider.dart';

class PromptDetailPage extends StatelessWidget {
  const PromptDetailPage({super.key});

  void _savePrompt(BuildContext context, PromptDetailViewModel viewModel) {
    viewModel.updatePrompt();
  }

  void _deletePrompt(BuildContext context, PromptDetailViewModel viewModel) {
    viewModel.deletePrompt();
  }

  void _backToPromptsList(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PromptDetailViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Prompt Detail'),
            leading: IconButton(
              onPressed: viewModel.isLoading
                  ? null
                  : () => _backToPromptsList(context),
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
                              onPublicChanged: (value) {
                                viewModel.setIsPublic(value);
                              },
                            ),
                            SizedBox(height: 16),
                            PromptDetailActionButtons(
                              title: viewModel.titleController.text,
                              onSaveChange: viewModel.isLoading
                                  ? () {}
                                  : () => _savePrompt(context, viewModel),
                              onDelete: viewModel.isLoading
                                  ? () {}
                                  : () => _deletePrompt(context, viewModel),
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
