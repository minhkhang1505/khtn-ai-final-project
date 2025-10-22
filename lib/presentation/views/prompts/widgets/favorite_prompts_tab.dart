import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompt_item.dart';

class FavoritePromptsTab extends StatelessWidget {
  final List<Prompt> prompts;
  final Function(Prompt)? onFavoriteTap;

  const FavoritePromptsTab({
    super.key,
    required this.prompts,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final favoritePrompts = prompts.where((p) => p.isFavorite).toList();

    if (favoritePrompts.isEmpty) {
      return const Center(child: Text('No favorite prompts yet'));
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        for (var prompt in favoritePrompts)
          PromptItem(
            prompt: prompt,
            onFavoriteTap: () => onFavoriteTap?.call(prompt),
          ),
      ],
    );
  }
}
