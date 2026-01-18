import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/empty_widget.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/error_dialog_widget.dart';
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
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;
  bool _hasLoadedInitial = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewmodel = Provider.of<KnowledgeBaseViewmodel>(
        context,
        listen: false,
      );
      if (!_hasLoadedInitial) {
        _hasLoadedInitial = true;
        final query = _searchController.text.trim();
        await viewmodel.getAllKnowledges(query: query.isEmpty ? null : query);
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
          body: LayoutBuilder(
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
                          // Search + Filter section
                          Row(
                            children: [
                              Expanded(child: _buildSearchField(context)),
                              const SizedBox(width: 12),
                              const FilterChipMenu(),
                            ],
                          ),
                          Expanded(
                            child: switch (vm.state) {
                              KnowledgeBaseState.initial =>
                                const EmptyStateWidget(
                                  message: 'Welcome to Knowledge Base',
                                ),
                              KnowledgeBaseState.loading =>
                                const LoadingIndicatorWidget(),
                              KnowledgeBaseState.failure => FailureStateWidget(
                                onRetry: () {
                                  vm.getAllKnowledges();
                                },
                              ),
                              KnowledgeBaseState.success =>
                                vm.knowledges == null || vm.knowledges!.isEmpty
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
                                            if (index ==
                                                vm.knowledges!.length) {
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
                                              onDelete: () => _handleDelete(
                                                context,
                                                vm.knowledges![index].id,
                                              ),
                                              onTap: () => onItemTap(
                                                context,
                                                vm.knowledges![index],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
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

  Future<void> _handleDelete(BuildContext context, String knowledgeId) async {
    // Show confirmation dialog first
    final confirmed = await ErrorDialogWidget.show(
      context,
      title: 'Delete Knowledge',
      errorMessage:
          'Are you sure you want to delete this knowledge base? This action cannot be undone.',
      showConfirmButton: true,
      confirmText: 'Delete',
      closeText: 'Cancel',
    );

    // Only proceed if user confirmed
    if (confirmed != true || !context.mounted) return;

    final vm = context.read<KnowledgeBaseViewmodel>();
    final success = await vm.deleteKnowledge(knowledgeId, autoRefresh: true);

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Knowledge base deleted successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete knowledge base'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void onItemTap(BuildContext context, KnowledgeEntity knowledge) async {
    // Navigate to knowledge details page
    final result = await Navigator.pushNamed(
      context,
      '/knowledge/details',
      arguments: knowledge,
    );

    // Refresh data if knowledge was updated or deleted successfully
    if (result == true && context.mounted) {
      final viewmodel = Provider.of<KnowledgeBaseViewmodel>(
        context,
        listen: false,
      );
      // Refresh the entire knowledge list to get latest data
      await viewmodel.refreshKnowledges();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Knowledge list refreshed'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  Widget _buildSearchField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: _searchController,
      onChanged: _onSearchChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                  context.read<KnowledgeBaseViewmodel>().getAllKnowledges(
                    query: '',
                  );
                },
              )
            : null,
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh.withAlpha(120),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _onSearchChanged(String value) {
    setState(() {});
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      context.read<KnowledgeBaseViewmodel>().getAllKnowledges(query: value);
    });
  }
}
