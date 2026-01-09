import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/domain/models/knowledge_source_type.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/error_dialog_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/datasource_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/knowledge_detail_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_form.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledgedetail/widgets/add_data_source_bottom_sheet.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/datasource/data_source_list.dart';
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
  late DataSourceType initialSourceType;

  @override
  void initState() {
    super.initState();

    _sourceDescriptionController = TextEditingController();
    _sourceNameController = TextEditingController();
    _urlController = TextEditingController();
    initialSourceType = DataSourceTypes.url;
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
          floatingActionButton: vm.state == KnowledgeDetailState.success
              ? FloatingActionButton.extended(
                  onPressed: _showAddDataSourceBottomSheet,
                  icon: const Icon(Icons.add),
                  label: const Text("DataSource"),
                )
              : null,
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
                        child: Column(
                          children: [
                            KnowledgeForm(
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
                                  }) => _handleSave(
                                    context,
                                    sourceName: sourceName,
                                    sourceDescription: sourceDescription,
                                  ),
                              // onDelete: () => _handleDelete(context),
                            ),
                            const SizedBox(height: 24),
                            Consumer<DatasourceViewmodel>(
                              builder: (context, datasourceVm, child) {
                                if (datasourceVm.dataSource.isEmpty) {
                                  return _buildEmptyDataSourceWidget();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        'Data Sources',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 400,
                                      child: const DataSourceList(),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
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

  void _showAddDataSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddDataSourceBottomSheet(),
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

  Future<void> _handleSave(
    BuildContext context, {
    required String sourceName,
    required String sourceDescription,
  }) async {

    final vm = context.read<KnowledgeDetailViewmodel>();
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    vm.setKnowledgeName(sourceName);
    vm.setKnowledgeDescription(sourceDescription);

    final success = await vm.updateKnowledge();

    // Use mounted property from State instead of context.mounted
    if (!mounted) {
      return;
    }

    if (success) {

      setState(() {
        _isEditMode = false;
      });

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Knowledge source "$sourceName" updated successfully'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // Wait for SnackBar and API propagation
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) {
        return;
      }

      // Pop with true to trigger knowledge list refresh
      navigator.pop(true);
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Failed to update knowledge source. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Widget _buildEmptyDataSourceWidget() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/ic_empty_list.svg',
            height: 120,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No Data Sources',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add data sources to this knowledge base\nusing the button below',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
