import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/empty_widget.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompt_item.dart';

class FavoritePromptsTab extends StatelessWidget {
  final List<PromptEntity> prompts;
  final Function(PromptEntity)? onFavoriteTap;

  const FavoritePromptsTab({
    super.key,
    required this.prompts,
    this.onFavoriteTap,
  });

  void _handleItemTap(BuildContext context, PromptEntity prompt) {
    Navigator.pushNamed(context, '/prompts/details', arguments: prompt.id);
  }

  @override
  Widget build(BuildContext context) {
    final favoritePrompts = prompts.where((p) => p.isFavorite).toList();

    if (favoritePrompts.isEmpty) {
      return EmptyPromptWidget(message: "No favorite prompts available.");
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        for (var prompt in favoritePrompts)
          PromptItem(
            onTap: () => _handleItemTap(context, prompt),
            prompt: prompt,
            onFavoriteTap: () => onFavoriteTap?.call(prompt),
          ),
      ],
    );
  }
}
