import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt/prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompt_item.dart';

class PromptCategoryTab extends StatelessWidget {
  final PromptViewmodel viewModel;
  final List<PromptEntity> categoryPrompts;
  final ScrollController scrollController;
  final String selectedCategoryName;
  final VoidCallback onPickCategory;
  final Future<void> Function() onRefresh;
  final void Function(PromptEntity prompt) onPromptTap;

  const PromptCategoryTab({
    super.key,
    required this.viewModel,
    required this.categoryPrompts,
    required this.scrollController,
    required this.selectedCategoryName,
    required this.onPickCategory,
    required this.onRefresh,
    required this.onPromptTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: _buildCategoryPromptList(context)),
        Positioned(
          left: 10,
          right: 10,
          bottom: 16,
          child: ElevatedButton.icon(
            onPressed: onPickCategory,
            icon: const Icon(Icons.arrow_drop_up, size: 20),
            label: Text('Category: $selectedCategoryName'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface.withAlpha(230),
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              elevation: 4,
              shadowColor: Colors.black.withAlpha(100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: const Size(0, 36),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryPromptList(BuildContext context) {
    final loadMoreState = viewModel.categoryLoadMoreState;
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        itemCount: categoryPrompts.length + 1,
        itemBuilder: (context, index) {
          if (index == categoryPrompts.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: switch (loadMoreState) {
                  LoadMoreState.loading => const CircularProgressIndicator(),
                  LoadMoreState.noMoreData => const Text(
                    "No more prompts to load.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  LoadMoreState.idle => const SizedBox.shrink(),
                },
              ),
            );
          }
          final prompt = categoryPrompts[index];
          return PromptItem(
            onTap: () => onPromptTap(prompt),
            prompt: prompt,
            onFavoriteTap: () {
              if (prompt.isFavorite) {
                viewModel.removeFromFavorite(prompt.id);
              } else {
                viewModel.addPromptToFavorite(prompt.id);
              }
            },
          );
        },
      ),
    );
  }
}
