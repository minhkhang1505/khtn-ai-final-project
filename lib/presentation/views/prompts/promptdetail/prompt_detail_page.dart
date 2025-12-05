import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/failure_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt_detail_view_model.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/newprompt/widgets/prompt_details_section.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/promptdetail/widgets/prompt_detail_action_buttons.dart';
import 'package:provider/provider.dart';

class PromptDetailPage extends StatefulWidget {
  const PromptDetailPage({super.key});

  @override
  State<PromptDetailPage> createState() => _PromptDetailPageState();
}

class _PromptDetailPageState extends State<PromptDetailPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _savePrompt(PromptDetailViewModel viewModel) {
    viewModel.updatePrompt(
      title: titleController.text,
      description: descriptionController.text,
      content: contentController.text,
    );
  }

  void _deletePrompt(PromptDetailViewModel viewModel) {
    viewModel.deletePrompt();
  }

  void _backToPromptsList() {
    final viewModel = context.read<PromptDetailViewModel>();
    viewModel.clearItem();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PromptDetailViewModel>(
      builder: (context, viewModel, child) {
        // Update controllers when data is loaded
        if (!viewModel.isLoading && titleController.text.isEmpty) {
          titleController.text = viewModel.title;
          descriptionController.text = viewModel.description;
          contentController.text = viewModel.content;
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Prompt Detail'),
            leading: IconButton(
              onPressed: viewModel.isLoading ? null : _backToPromptsList,
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWideScreen = constraints.maxWidth > 600;
              if (viewModel.promptDetailState == PromptDetailState.loading) {
                return LoadingIndicatorWidget();
              } else if (viewModel.promptDetailState ==
                  PromptDetailState.success) {
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
                              // Show loading indicator while fetching data
                              if (viewModel.isLoading)
                                const CircularProgressIndicator()
                              else ...[
                                PromptDetailsSection(
                                  titleController: titleController,
                                  descriptionController: descriptionController,
                                  contentController: contentController,
                                  selectedCategory: viewModel.selectedCategory,
                                  selectedLanguage: viewModel.selectedLanguage,
                                  isPublic: viewModel.isPublic,
                                  onCategoryChanged: (value) {
                                    if (value != null)
                                      viewModel.setCategory(value);
                                  },
                                  onLanguageChanged: (value) {
                                    if (value != null)
                                      viewModel.setLanguage(value);
                                  },
                                  onPublicChanged: (value) {
                                    viewModel.setIsPublic(value);
                                  },
                                ),
                                const SizedBox(height: 16),
                                PromptDetailActionButtons(
                                  title: titleController.text,
                                  onSaveChange: () => _savePrompt(viewModel),
                                  onDelete: () => _deletePrompt(viewModel),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return FailureStateWidget(
                  onRetry: () {
                    viewModel.loadPromptDetails();
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
