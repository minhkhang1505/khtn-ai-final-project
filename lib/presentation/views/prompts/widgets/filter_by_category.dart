import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompt_item.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/empty_prompt_widget.dart';

class FilterByCategory extends StatelessWidget {
  final List<PromptEntity> prompts;
  final void Function(PromptEntity)? onFavoriteTap;

  const FilterByCategory({
    super.key,
    required this.prompts,
    this.onFavoriteTap,
  });

  void _handleItemTap(BuildContext context, PromptEntity prompt) {
    // Implement navigation or other logic here
  }

  @override
  Widget build(BuildContext context) {
    if (prompts.isEmpty) {
      return EmptyPromptWidget(message: "No favorite prompts available.");
    }

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
