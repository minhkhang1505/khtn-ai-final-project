import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/models/knowledge_source_type.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_form.dart';

/// Screen for viewing and editing knowledge source details
class KnowledgeDetailScreen extends StatefulWidget {
  // TODO: Add parameters to accept knowledge data from navigation
  final String? knowledgeId;
  final String? initialSourceName;
  final String? initialSourceDescription;
  final String? initialUrl;
  final KnowledgeSourceType? initialSourceType;

  const KnowledgeDetailScreen({
    super.key,
    this.knowledgeId,
    this.initialSourceName,
    this.initialSourceDescription,
    this.initialUrl,
    this.initialSourceType,
  });

  @override
  State<KnowledgeDetailScreen> createState() => _KnowledgeDetailScreenState();
}

class _KnowledgeDetailScreenState extends State<KnowledgeDetailScreen> {
  bool _isEditMode = false;

  void _handleEdit() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditMode ? 'Edit mode activated' : 'View mode activated',
        ),
      ),
    );
  }

  void _handleSave(
    BuildContext context, {
    required String sourceName,
    required String sourceDescription,
    required String url,
    required sourceType,
  }) {
    // TODO: Implement update logic
    // This is where you would call your repository/service to update the knowledge

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Knowledge source "$sourceName" updated successfully'),
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
        title: const Text('Knowledge Details'),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: KnowledgeForm(
                    initialSourceName: widget.initialSourceName,
                    initialSourceDescription: widget.initialSourceDescription,
                    initialUrl: widget.initialUrl,
                    initialSourceType: widget.initialSourceType,
                    isEditMode: _isEditMode,
                    onEditPressed: _handleEdit,
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
          );
        },
      ),
    );
  }
}
