import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/empty_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/failure_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/knowledge_base_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_filter.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_item.dart';
import 'package:provider/provider.dart';

/// Knowledge page - Knowledge base management
class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewmodel = Provider.of<KnowledgeBaseViewmodel>(
        context,
        listen: false,
      );
      if (viewmodel.knowledges == null || viewmodel.knowledges!.isEmpty) {
        await viewmodel.getAllKnowledges();
      }
    });

    return Consumer<KnowledgeBaseViewmodel>(
      builder: (context, vm, child) {
        vm.knowledges?.forEach((knowledge) {});
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Knowledge',
            subtitle: 'Connect data sources',
            onCreatePressed: () => _onAddKnowledge(context),
            createButtonLabel: 'Add Knowledge',
          ),
          body: switch (vm.state) {
            KnowledgeBaseState.initial => const EmptyStateWidget(
              message: 'Welcome to Knowledge Base',
            ),
            KnowledgeBaseState.loading => const LoadingIndicatorWidget(),
            KnowledgeBaseState.failure => FailureStateWidget(
              onRetry: () {
                vm.getAllKnowledges();
              },
            ),
            KnowledgeBaseState.success => LayoutBuilder(
              builder: (context, constraints) {
                final bool isWideScreen = constraints.maxWidth > 600;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWideScreen ? 1200 : double.infinity,
                    ),
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            // Filter section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [FilterChipMenu()],
                            ),
                            Expanded(
                              child:
                                  vm.knowledges == null ||
                                      vm.knowledges!.isEmpty
                                  ? EmptyPromptWidget(
                                      message:
                                          "Not found any knowledge base. Please add new knowledge base.",
                                    )
                                  : RefreshIndicator(
                                      onRefresh: _onRefresh,
                                      color: Theme.of(context).primaryColor,

                                      child: ListView.builder(
                                        controller: _scrollController,
                                        padding: const EdgeInsets.fromLTRB(
                                          0,
                                          8,
                                          0,
                                          90,
                                        ),
                                        itemCount:
                                            vm.knowledges!.length +
                                            (vm.loadMoreState ==
                                                    LoadMoreKnowledgeState
                                                        .loading
                                                ? 1
                                                : 0),
                                        itemBuilder: (context, index) {
                                          if (index == vm.knowledges!.length) {
                                            return const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          }
                                          return KnowledgeItem(
                                            iconPath:
                                                'assets/icons/ic_knowledge.svg',
                                            knowledge: vm.knowledges![index],
                                          );
                                        },
                                      ),
                                    ),
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

  void _onAddKnowledge(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/knowledge/new');

    // Refresh data if knowledge was created successfully
    if (result == true && context.mounted) {
      final viewmodel = Provider.of<KnowledgeBaseViewmodel>(
        context,
        listen: false,
      );
      await viewmodel.refreshKnowledges();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final vm = context.read<KnowledgeBaseViewmodel>();

      if (vm.loadMoreState == LoadMoreKnowledgeState.idle && vm.hasNext) {
        vm.loadMoreKnowledges();
      }
    }
  }

  Future<void> _onRefresh() async {
    final vm = context.read<KnowledgeBaseViewmodel>();
    await vm.refreshKnowledges();
  }

  void onItemTap(BuildContext context, KnowledgeEntity knowledge) async {
    // Navigate to knowledge details page
    final result = await Navigator.pushNamed(
      context,
      '/knowledge/details',
      arguments: knowledge,
    );

    // Refresh data if knowledge was deleted successfully
    if (result == true && context.mounted) {
      final viewmodel = Provider.of<KnowledgeBaseViewmodel>(
        context,
        listen: false,
      );
      await viewmodel.refreshKnowledges();
    }
  }
}
