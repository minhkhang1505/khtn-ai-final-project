import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/constants/knowledge_constants.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_form.dart';

/// Screen for creating a new knowledge source
class NewKnowledgeScreen extends StatelessWidget {
  const NewKnowledgeScreen({super.key});

  void _handleSave(
    BuildContext context, {
    required String sourceName,
    required String sourceDescription,
    required String url,
    required sourceType,
  }) {
    // TODO: Implement save logic
    // This is where you would call your repository/service to save the knowledge

    // For now, just show a success message and pop
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Knowledge source "$sourceName" saved successfully'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(KnowledgeConstants.newKnowledgeTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Center(
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
                      onSave:
                          ({
                            required String sourceName,
                            required String sourceDescription,
                            required String url,
                            required sourceType,
                          }) => _handleSave(
                            context,
                            sourceName: sourceName,
                            sourceDescription: sourceDescription,
                            url: url,
                            sourceType: sourceType,
                          ),
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
