import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/categories.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/empty_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt_viewmodel.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<PromptViewmodel>(context, listen: false);
      viewModel.getPromptByCategory(widget.category);
    });
  }

  void _handleItemTap(BuildContext context, PromptEntity prompt) {
    Navigator.pushNamed(context, '/prompt-detail', arguments: prompt);
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

          final prompts = viewModel.categoryPrompts ?? [];

          if (prompts.isEmpty) {
            return const EmptyPromptWidget(
              message: "No prompts available in this category.",
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: prompts.length,
            itemBuilder: (context, index) {
              final prompt = prompts[index];
              return PromptItem(
                onTap: () => _handleItemTap(context, prompt),
                prompt: prompt,
                onFavoriteTap: () async {
                  if (prompt.isFavorite) {
                    await viewModel.removeFromFavorite(prompt.id);
                  } else {
                    await viewModel.addPromptToFavorite(prompt.id);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
