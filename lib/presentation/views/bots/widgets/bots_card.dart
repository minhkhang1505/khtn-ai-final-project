import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/utils/icon_ai_model_helper.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';

/// Card to display individual AI bot information
class BotCard extends StatelessWidget {
  final BotModel bot;

  const BotCard({super.key, required this.bot});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.medium,
        side: BorderSide(color: colorScheme.outline.withAlpha(50), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Bot icon
                SvgPicture.asset(
                  'assets/icons/ic_bot.svg',
                  width: 40,
                  height: 40,
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),

                // Name of Bot (use model's display name)
                Expanded(
                  child: Text(
                    bot.assistantName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),

                // Edit Bot button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Edit Bot page
                    Navigator.pushNamed(context, '/bots/edit', arguments: bot);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.grey.shade300;
                      }
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.grey.shade400;
                      }
                      return Colors.transparent;
                    }),
                    elevation: WidgetStateProperty.all(0),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    shape: WidgetStateProperty.all(const CircleBorder()),
                    padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                  ),
                  child: Icon(
                    Icons.settings,
                    size: 24,
                    color: colorScheme.outline,
                  ),
                ),
              ],
            ),
            // Description of Bot
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                bot.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),

            // Model
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(IconAiModelHelper.iconForModel(AssistantModelType.nameFromId(bot.model?.id ?? '')), size: 20),
                const SizedBox(width: 8),
                Text(
                  AssistantModelType.nameFromId(bot.model?.id ?? ''),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
