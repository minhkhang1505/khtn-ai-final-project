import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/utils/icon_ai_model_helper.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat_view_model.dart';

class BotOptionMenu extends StatefulWidget {
  const BotOptionMenu({super.key});

  @override
  State<BotOptionMenu> createState() => _BotOptionMenuState();
}

class _BotOptionMenuState extends State<BotOptionMenu> {
  final List<Map<String, dynamic>> models = AssistantModelType.values.map((type) {
    return {
      "name": type.name,
      "id": type.id,
    };
  }).toList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final vm = context.read<ChatViewModel>();

    return PopupMenuButton<String>(
      onSelected: (value) {
        final selected = models.firstWhere((model) => model["name"] == value);
        vm.selectedModelSetter = selected["id"];

        vm.assistant = AssistantModel(
          model: 'dify',
          name: selected["name"],
          id: selected["id"],
        );
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
              Icon(IconAiModelHelper.iconForModel(name), size: 20),
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
            Icon(
              IconAiModelHelper.iconForModel(vm.selectedModel),
              size: 20, 
              color: colorScheme.onSurface,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                AssistantModelType.fromId(vm.selectedModel)?.name ?? 'Select Model',
                style: const TextStyle(fontSize: 15),
                //overflow: TextOverflow.ellipsis,
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
