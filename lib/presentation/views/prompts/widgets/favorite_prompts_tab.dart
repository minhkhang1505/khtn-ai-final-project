import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompt_item.dart';

class FavoritePromptsTab extends StatefulWidget {
  final List<Prompt> prompts;
  final Function(Prompt)? onFavoriteTap;

  const FavoritePromptsTab({
    super.key,
    required this.prompts,
    this.onFavoriteTap,
  });

  @override
  State<FavoritePromptsTab> createState() => _FavoritePromptsTabState();
}

class _FavoritePromptsTabState extends State<FavoritePromptsTab> {
  void handleItemTap(Prompt prompt) {
    Navigator.pushNamed(context, '/prompts/details', arguments: prompt);
  }

  @override
  Widget build(BuildContext context) {
    final favoritePrompts = widget.prompts.where((p) => p.isFavorite).toList();

    if (favoritePrompts.isEmpty) {
      return const Center(child: Text('No favorite prompts yet'));
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        for (var prompt in favoritePrompts)
          PromptItem(
            onTap: () => handleItemTap(prompt),
            prompt: prompt,
            onFavoriteTap: () => widget.onFavoriteTap?.call(prompt),
          ),
      ],
    );
  }
}
