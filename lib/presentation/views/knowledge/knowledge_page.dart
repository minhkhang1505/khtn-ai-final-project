import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/empty_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/failure_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge_base_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_filter.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_item.dart';
import 'package:provider/provider.dart';

/// Knowledge page - Knowledge base management
class KnowledgePage extends StatelessWidget {
  const KnowledgePage({super.key});

  void _onAddKnowledge(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/knowledge/new');

    // Refresh data if knowledge was created successfully
    if (result == true && context.mounted) {
      final viewmodel = Provider.of<KnowledgeBaseViewmodel>(
        context,
        listen: false,
      );
      await viewmodel.getAllKnowledges();
    }
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
        debugPrint("Khang: ${vm.knowledges?.length}");
        vm.knowledges?.forEach((knowledge) {
          debugPrint('📚 Khang: ${knowledge.knowledgeName}');
        });
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
                      child: SafeArea(
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
                                    : ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        itemCount: vm.knowledges!.length,
                                        itemBuilder: (context, index) =>
                                            KnowledgeItem(
                                              iconPath:
                                                  'assets/icons/ic_url.svg',
                                              knowledge: vm.knowledges![index],
                                            ),
                                      ),
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
          },
        );
      },
    );
  }
}
