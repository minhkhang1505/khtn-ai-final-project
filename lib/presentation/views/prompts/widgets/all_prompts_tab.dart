import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompt_item.dart';

class AllPromptsTab extends StatelessWidget {
  final List<PromptEntity> prompts;
  final Function(PromptEntity)? onFavoriteTap;

  const AllPromptsTab({super.key, required this.prompts, this.onFavoriteTap});

  void _handleItemTap(BuildContext context, PromptEntity prompt) {
    debugPrint(
      'Khang - Navigating to PromptDetailPage for prompt id: ${prompt.id}',
    );
    Navigator.pushNamed(context, '/prompts/details', arguments: prompt);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        for (var prompt in prompts)
          PromptItem(
            onTap: () => _handleItemTap(context, prompt),
            prompt: prompt,
            onFavoriteTap: () => onFavoriteTap?.call(prompt),
          ),
      ],
    );
  }
}
