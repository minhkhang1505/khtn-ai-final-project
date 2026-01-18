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
  bool _isOpening = false;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleSelected(Map<String, dynamic> value) async {
    final String id = value['id'] as String;
    final String name = value['name'] as String;
    final String model = value['type'] == 'bot' ? 'knowledge-base' : 'agentic';

    final assistant = AssistantModel(model: model, id: id, name: name);
    chatAppBarViewModel.setSelectedAssistant(assistant);
    widget.onSelected(assistant);
  }

  List<PopupMenuEntry<Map<String, dynamic>>> _buildMenuItems(
    ColorScheme colorScheme,
  ) {
    final userBots = chatAppBarViewModel.userBots;
    final baseModels = chatAppBarViewModel.baseModels;

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

    if (userBots.isEmpty && baseModels.isEmpty) {
      return [
        const PopupMenuItem<Map<String, dynamic>>(
          enabled: false,
          child: Text('No models available'),
        ),
      ];
    }

    List<PopupMenuEntry<Map<String, dynamic>>> items = [];

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
  }

  Future<void> _openMenu(BuildContext context, ColorScheme colorScheme) async {
    if (_isOpening) return;
    setState(() {
      _isOpening = true;
    });

    await chatAppBarViewModel.fetchAvailableModels();

    setState(() {
      _isOpening = false;
    });

    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final result = await showMenu<Map<String, dynamic>>(
      context: context,
      position: position,
      items: _buildMenuItems(colorScheme),
      color: colorScheme.surfaceBright,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
      elevation: 4,
    );

    if (result != null) {
      await _handleSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: chatAppBarViewModel,
      builder: (context, _) {
        final assistant = chatAppBarViewModel.selectedAssistant;
        String displayName = assistant.name;

        return InkWell(
          borderRadius: AppBorderRadius.medium,
          onTap: () => _openMenu(context, colorScheme),
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
                _isOpening
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.primary,
                        ),
                      )
                    : const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        );
      },
    );
  }
}
