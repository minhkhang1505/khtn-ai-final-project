import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/categories.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/empty_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt/prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompt_item.dart';
import 'package:provider/provider.dart';

class FilterByCategoryPage extends StatefulWidget {
  final CategoryType category;
  final String categoryName;

  const FilterByCategoryPage({
    super.key,
    required this.category,
    required this.categoryName,
  });

  @override
  State<FilterByCategoryPage> createState() => _FilterByCategoryPageState();
}

class _FilterByCategoryPageState extends State<FilterByCategoryPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<PromptViewmodel>(context, listen: false);
      viewModel.getPromptByCategory(widget.category);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final viewModel = context.read<PromptViewmodel>();

      if (viewModel.loadMoreState == LoadMoreState.idle && viewModel.hasNext) {
        debugPrint(
          'FilterByCategoryPage: Reached bottom, loading more prompts...',
        );
        viewModel.loadMoreCategoryPrompts();
      }
    }
  }

  Future<void> _onRefresh() async {
    final viewModel = context.read<PromptViewmodel>();
    await viewModel.getPromptByCategory(widget.category);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleItemTap(BuildContext context, PromptEntity prompt) async {
    final result = await Navigator.pushNamed(
      context,
      '/prompts/details',
      arguments: prompt,
    );

    // If result is prompt content to use, pop back to home with it
    if (result is String && result.isNotEmpty && context.mounted) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName), centerTitle: true),
      body: Consumer<PromptViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.viewState == PromptViewState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.viewState == PromptViewState.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load prompts'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.getPromptByCategory(widget.category);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final categoryPrompts = viewModel.categoryPrompts ?? [];

          if (categoryPrompts.isEmpty) {
            return const EmptyPromptWidget(
              message: "No prompts available in this category.",
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: Theme.of(context).primaryColor,

            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              // +1 for the footer row (loading / no-more-data)
              itemCount: categoryPrompts.length + 1,
              itemBuilder: (context, index) {
                if (index == categoryPrompts.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: switch (viewModel.loadMoreState) {
                        LoadMoreState.loading =>
                          const CircularProgressIndicator(),
                        LoadMoreState.noMoreData => const Text(
                          "No more prompts to load.",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        LoadMoreState.idle => const SizedBox.shrink(),
                      },
                    ),
                  );
                }
                final categoryPromptItem = categoryPrompts[index];
                return PromptItem(
                  onTap: () => _handleItemTap(context, categoryPromptItem),
                  prompt: categoryPromptItem,
                  onFavoriteTap: () async {
                    if (categoryPromptItem.isFavorite) {
                      await viewModel.removeFromFavorite(categoryPromptItem.id);
                    } else {
                      await viewModel.addPromptToFavorite(
                        categoryPromptItem.id,
                      );
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
