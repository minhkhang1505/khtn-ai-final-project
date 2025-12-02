import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompt_item.dart';

class AllPromptsTab extends StatefulWidget {
  final List<PromptEntity> prompts;
  final Function(PromptEntity)? onFavoriteTap;

  const AllPromptsTab({super.key, required this.prompts, this.onFavoriteTap});

  @override
  State<AllPromptsTab> createState() => _AllPromptsTabState();
}

class _AllPromptsTabState extends State<AllPromptsTab> {
  void handleItemTap(PromptEntity prompt) {
    Navigator.pushNamed(context, '/prompts/details', arguments: prompt.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        for (var prompt in widget.prompts)
          PromptItem(
            onTap: () => handleItemTap(prompt),
            prompt: prompt,
            onFavoriteTap: () => widget.onFavoriteTap?.call(prompt),
          ),
      ],
    );
  }
}
