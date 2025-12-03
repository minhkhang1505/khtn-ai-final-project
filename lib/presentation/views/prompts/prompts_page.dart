import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/categories.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/all_prompts_tab.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/categories_tab.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/empty_prompt_widget.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/failure_widget.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/favorite_prompts_tab.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompts_tab_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt_viewmodel.dart';
import 'package:provider/provider.dart';

/// Prompts page - Manage AI prompts
class PromptsPage extends StatelessWidget {
  const PromptsPage({super.key});

  void _handleAddPrompt(BuildContext context) {
    Navigator.pushNamed(context, '/prompts/new');
  }

  void _handleFavoriteTap(BuildContext context, PromptEntity prompt) {
    final viewmodel = Provider.of<PromptViewmodel>(context, listen: false);
    // Toggle favorite status via viewmodel
    if (prompt.isFavorite) {
      viewmodel.removeFromFavorite(prompt.id);
    } else {
      viewmodel.addPromptToFavorite(prompt.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Load prompts when widget builds for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = Provider.of<PromptViewmodel>(context, listen: false);
      if (viewmodel.prompts == null || viewmodel.prompts!.isEmpty) {
        viewmodel.getAllPrompts();
      }
      if (viewmodel.favoritePrompts == null ||
          viewmodel.favoritePrompts!.isEmpty) {
        viewmodel.getFavoritePrompts();
      }
    });

    return Consumer<PromptViewmodel>(
      builder: (context, viewmodel, child) {
        final prompts = viewmodel.prompts ?? [];
        final favoritePrompts = viewmodel.favoritePrompts ?? [];

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'AI Prompts',
              subtitle: 'Browse and manage your AI prompts',
              onCreatePressed: () => _handleAddPrompt(context),
              createButtonLabel: 'Add Prompt',
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                final bool isWideScreen = constraints.maxWidth > 600;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWideScreen ? 1200 : double.infinity,
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          PromptsTabBar(
                            controller: DefaultTabController.of(context),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                switch (viewmodel.viewState) {
                                  PromptViewState.loading =>
                                    LoadingIndicatorWidget(),
                                  PromptViewState.failure => FailureWidget(
                                    onRetry: () {
                                      viewmodel.getAllPrompts();
                                    },
                                  ),
                                  PromptViewState.initial => EmptyPromptWidget(
                                    message:
                                        "No prompts found. Please add new prompts.",
                                  ),
                                  PromptViewState.success => AllPromptsTab(
                                    prompts: prompts,
                                    onFavoriteTap: (prompt) =>
                                        _handleFavoriteTap(context, prompt),
                                  ),
                                },

                                CategoriesTab(categories: categories),

                                switch (viewmodel.viewState) {
                                  PromptViewState.loading =>
                                    LoadingIndicatorWidget(),
                                  PromptViewState.failure => FailureWidget(
                                    onRetry: () {
                                      viewmodel.getFavoritePrompts();
                                    },
                                  ),
                                  PromptViewState.initial => EmptyPromptWidget(
                                    message:
                                        "No prompts found. Please add new prompts.",
                                  ),
                                  PromptViewState.success => FavoritePromptsTab(
                                    prompts: favoritePrompts,
                                    onFavoriteTap: (prompt) =>
                                        _handleFavoriteTap(context, prompt),
                                  ),
                                },
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
