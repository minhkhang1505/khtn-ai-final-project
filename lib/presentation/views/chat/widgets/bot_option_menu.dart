import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/core/utils/ai_model_icon_helper.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_app_bar_view_model.dart';

class BotOptionMenu extends StatefulWidget {
  final ValueChanged<AssistantModel> onSelected;
  
  const BotOptionMenu({super.key, required this.onSelected});

  @override
  State<BotOptionMenu> createState() => _BotOptionMenuState();
}

class _BotOptionMenuState extends State<BotOptionMenu> {
  final ChatAppBarViewModel chatAppBarViewModel = sl<ChatAppBarViewModel>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userBots = chatAppBarViewModel.userBots;
    final baseModels = chatAppBarViewModel.baseModels;

    return PopupMenuButton<Map<String, dynamic>>(
      onSelected: (value) {
        final String id = value['id'] as String;
        final String name = value['name'] as String;
        // TODO: mode == knowledge base (bot) or agentic
        final String model = value['type'] == 'bot' ? '' : 'agentic';

        final assistant = AssistantModel(model: model, id: id, name: name);
        chatAppBarViewModel.setSelectedAssistant(assistant);
        widget.onSelected(assistant);
      },
      color: colorScheme.surfaceBright,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
      elevation: 4,
      itemBuilder: (context) {
        List<PopupMenuEntry<Map<String, dynamic>>> items = [];

        if (chatAppBarViewModel.isLoading) {
          return [
            PopupMenuItem<Map<String, dynamic>>(
              enabled: false,
              child: Center(
                child: CircularProgressIndicator(
                  color: colorScheme.primary,
                ),
              ),
            ),
          ];
        }

        // Check if userBots or baseModels are empty
        if (userBots.isEmpty && baseModels.isEmpty) {
          return [
            const PopupMenuItem<Map<String, dynamic>>(
              enabled: false,
              child: Text('No models available'),
            ),
          ];
        }
        
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
            final displayName = type.displayName;
            return PopupMenuItem<Map<String, dynamic>>(
              value: {
                'type': 'model',
                'id': type.id,
                'name': displayName,
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AiModelIconHelper.iconForModel(displayName, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      displayName,
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
                  'id': bot.id,
                  'name': bot.assistantName,
                  'botData': bot,
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AiModelIconHelper.iconForModel(
                      bot.assistantName,
                      size: 16,
                      color: colorScheme.onSecondaryContainer,
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
      child: AnimatedBuilder(
        animation: chatAppBarViewModel,
        builder: (context, _) {

          final assistant = chatAppBarViewModel.selectedAssistant;
          String displayName = assistant.name;

          return Container(
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
                  displayName,
                  size: 16,
                  color: colorScheme.onSecondaryContainer,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    displayName,
                    style: const TextStyle(fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          );
        },
      ),
    );
  }
}
