import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/core/utils/ai_model_icon_helper.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/model_selector_view_model.dart';

class BotOptionMenu extends StatefulWidget {
  final ValueChanged<String> onSelected;
  
  const BotOptionMenu({super.key, required this.onSelected});

  @override
  State<BotOptionMenu> createState() => _BotOptionMenuState();
}

class _BotOptionMenuState extends State<BotOptionMenu> {
  final List<Map<String, dynamic>> models = AssistantModelType.values.map((type) {
    return {
      "name": type.displayName,
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
    final modelSelectorViewModel = sl<ModelSelectorViewModel>();
    final userBots = modelSelectorViewModel.userBots;
    final baseModels = modelSelectorViewModel.baseModels;

    return PopupMenuButton<Map<String, dynamic>>(
      onSelected: (value) {
        if (value['type'] == 'model') {
          modelSelectorViewModel.selectedModel = value['id'];
        } else if (value['type'] == 'bot') {
          // Handle bot selection - could store bot ID in viewmodel
          modelSelectorViewModel.selectedModel = value['id'];
        }
      },
      color: colorScheme.surfaceBright,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
      elevation: 4,
      itemBuilder: (context) {
        List<PopupMenuEntry<Map<String, dynamic>>> items = [];
        
        // Add base models section
        items.add(
          PopupMenuItem<Map<String, dynamic>>(
            enabled: false,
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                'Base Models',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        );
        
        // Add base models
        items.addAll(
          baseModels.map((type) {
            final name = type.displayName;
            return PopupMenuItem<Map<String, dynamic>>(
              value: {
                'type': 'model',
                'id': type.id,
                'name': name,
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AiModelIconHelper.iconForModel(name, size: 20),
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
        );
        
        // Add user bots section if there are any
        if (userBots.isNotEmpty) {
          items.add(const PopupMenuDivider());
          items.add(
            PopupMenuItem<Map<String, dynamic>>(
              enabled: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  'Your Bots',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.secondary,
                  ),
                ),
              ),
            ),
          );
          
          // Add user-created bots
          items.addAll(
            userBots.map((bot) {
              return PopupMenuItem<Map<String, dynamic>>(
                value: {
                  'type': 'bot',
                  'id': bot.openAiAssistantId ?? bot.id,
                  'name': bot.assistantName,
                  'botData': bot,
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.smart_toy,
                        size: 16,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            bot.assistantName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          if (bot.description.isNotEmpty)
                            Text(
                              bot.description,
                              style: TextStyle(
                                fontSize: 11,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }
        
        return items;
      },
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
            AiModelIconHelper.iconForModel(
              modelSelectorViewModel.selectedModel,
              size: 20,
              color: colorScheme.onSurface,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                AssistantModelType.getModelFromId(modelSelectorViewModel.selectedModel).displayName,
                style: const TextStyle(fontSize: 15),
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
