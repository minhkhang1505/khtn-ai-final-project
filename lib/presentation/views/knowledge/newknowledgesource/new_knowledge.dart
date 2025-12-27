import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/error_dialog_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/create_knowledge_base_viewmodel.dart';
import 'package:khtn_ai_final_project/core/constants/knowledge_constants.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_form.dart';
import 'package:provider/provider.dart';

/// Screen for creating a new knowledge source
class NewKnowledgeScreen extends StatelessWidget {
  const NewKnowledgeScreen({super.key});

  Future<void> _handleSave(
    BuildContext context,
    CreateKnowledgeBaseViewmodel viewmodel, {
    required String sourceName,
    required String sourceDescription,
  }) async {
    final response = await viewmodel.createNewKnowledge(
      sourceName,
      sourceDescription,
    );

    if (!context.mounted) return;

    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Knowledge source "$sourceName" saved successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateKnowledgeBaseViewmodel>(
      builder: (context, viewmodel, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text(KnowledgeConstants.newKnowledgeTitle),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: switch (viewmodel.state) {
            CreateKnowledgeBaseState.loading => const LoadingIndicatorWidget(),
            CreateKnowledgeBaseState.failure => ErrorDialogWidget(
              errorMessage:
                  "Failed to create knowledge source. Please try again.",
            ),
            _ => LayoutBuilder(
              builder: (context, constraints) {
                final bool isWideScreen = constraints.maxWidth > 600;
                return Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWideScreen ? 800 : double.infinity,
                    ),
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: KnowledgeForm(
                            isEditMode: true,
                            onSave:
                                ({
                                  required String sourceName,
                                  required String sourceDescription,
                                }) => _handleSave(
                                  context,
                                  viewmodel,
                                  sourceName: sourceName,
                                  sourceDescription: sourceDescription,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          },
        );
      },
    );
  }
}
