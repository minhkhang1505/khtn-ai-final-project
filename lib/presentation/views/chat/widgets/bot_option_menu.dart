import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';

class BotOptionMenu extends StatefulWidget {
  const BotOptionMenu({super.key});

  @override
  State<BotOptionMenu> createState() => _BotOptionMenuState();
}

class _BotOptionMenuState extends State<BotOptionMenu> {
  String selectedModel = "GPT_4O_MINI";

  final List<Map<String, dynamic>> models = AssistantModelType.values.map((type) {
    return {
      "name": type.name,
    };
  }).toList();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // helper to pick an icon for a model name
    IconData iconForModel(String name) {
      final key = name.toLowerCase();
      if (key.contains('gpt')) return Icons.smart_toy;
      if (key.contains('dall') || key.contains('image')) return Icons.image;
      if (key.contains('audio') || key.contains('whisper')) return Icons.mic;
      return Icons.auto_awesome;
    }

    return PopupMenuButton<String>(
      onSelected: (value) {
      setState(() => selectedModel = value);
      },
      color: colorScheme.surfaceBright,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
      elevation: 4,
      itemBuilder: (context) => AssistantModelType.values.map((type) {
      final name = type.name;
      return PopupMenuItem<String>(
        value: name,
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconForModel(name), size: 20),
          const SizedBox(width: 10),
          Expanded(
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          ),
        ],
        ),
      );
      }).toList(),
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceBright,
        borderRadius: AppBorderRadius.medium,
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              selectedModel,
              style: const TextStyle(fontSize: 15),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              ),
            ),
          const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
