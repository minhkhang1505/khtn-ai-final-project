import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/models/knowledge_source_type.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/error_dialog_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/knowledge_detail_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_form.dart';
import 'package:provider/provider.dart';

/// Screen for viewing and editing knowledge source details
class KnowledgeDetailScreen extends StatefulWidget {
  const KnowledgeDetailScreen({super.key});

  @override
  State<KnowledgeDetailScreen> createState() => _KnowledgeDetailScreenState();
}

class _KnowledgeDetailScreenState extends State<KnowledgeDetailScreen> {
  bool _isEditMode = false;
  late TextEditingController _sourceNameController;
  late TextEditingController _sourceDescriptionController;
  late TextEditingController _urlController;
  late KnowledgeSourceType initialSourceType;

  @override
  void initState() {
    super.initState();
    _sourceDescriptionController = TextEditingController();
    _sourceNameController = TextEditingController();
    _urlController = TextEditingController();
    initialSourceType = KnowledgeSourceTypes.url;
  }

  @override
  void dispose() {
    _sourceDescriptionController.dispose();
    _sourceNameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KnowledgeDetailViewmodel>(
      builder: (context, vm, child) {
        // Update controllers when data is successfully loaded
        if (vm.state == KnowledgeDetailState.success &&
            _sourceNameController.text.isEmpty) {
          _sourceNameController.text = vm.knowledgeName;
          _sourceDescriptionController.text = vm.knowledgeDescription;
          _urlController.text = vm.url;
          initialSourceType = vm.sourceType;
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('Knowledge Details'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: switch (vm.state) {
            KnowledgeDetailState.initial ||
            KnowledgeDetailState.loading => const LoadingIndicatorWidget(),
            KnowledgeDetailState.failure => ErrorDialogWidget(
              errorMessage:
                  'Failed to load knowledge details. Please try again.',
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
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: KnowledgeForm(
                          initialSourceName: _sourceNameController.text,
                          initialSourceDescription:
                              _sourceDescriptionController.text,
                          initialUrl: _urlController.text,
                          initialSourceType: initialSourceType,
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
          },
        );
      },
    );
  }

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
}
