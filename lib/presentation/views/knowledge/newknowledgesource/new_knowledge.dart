import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/network/knowledge_base_api_client.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/repositories/knowledge_base_repository_implement.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/create_knowledge_usecase.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/error_dialog_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/create_knowledge_base_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/constants/knowledge_constants.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_form.dart';
import 'package:provider/provider.dart';

/// Screen for creating a new knowledge source
class NewKnowledgeScreen extends StatefulWidget {
  const NewKnowledgeScreen({super.key});

  @override
  State<NewKnowledgeScreen> createState() => _NewKnowledgeScreenState();
}

class _NewKnowledgeScreenState extends State<NewKnowledgeScreen> {
  CreateKnowledgeBaseViewmodel? _viewmodel;

  @override
  void initState() {
    super.initState();
    _initializeViewModel();
  }

  Future<void> _initializeViewModel() async {
    final apiClient = await KnowledgeBaseApiClient.create();
    final viewmodel = CreateKnowledgeBaseViewmodel(
      createKnowledgeUsecase: CreateKnowledgeUsecase(
        repository: KnowledgeBaseRepositoryImplement(
          remoteDataSource: KnowledgeBaseRemoteDataSourceImpl(apiClient),
        ),
      ),
    );
    if (mounted) {
      setState(() {
        _viewmodel = viewmodel;
      });
    }
  }

  Future<void> _handleSave({
    required String sourceName,
    required String sourceDescription,
    required String url,
    required sourceType,
  }) async {
    final viewmodel = _viewmodel;
    if (viewmodel == null) return;

    final response = await viewmodel.createNewKnowledge(
      sourceName,
      sourceDescription,
    );

    if (!mounted) return;

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
  void dispose() {
    _viewmodel?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_viewmodel == null) {
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
        body: const LoadingIndicatorWidget(),
      );
    }

    return ChangeNotifierProvider.value(
      value: _viewmodel!,
      child: Consumer<CreateKnowledgeBaseViewmodel>(
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
              CreateKnowledgeBaseState.loading =>
                const LoadingIndicatorWidget(),
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
                                    required String url,
                                    required sourceType,
                                  }) => _handleSave(
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
            },
          );
        }
      ),
    );
  }
}
