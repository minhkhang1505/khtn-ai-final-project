import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/ai_model_option_menu.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/category_option_menu.dart';

class BotInformationCard extends StatelessWidget {
  const BotInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.medium,
        side: BorderSide(
          color: colorScheme.outlineVariant.withAlpha(100),
          width: 1.5,
        ),
      ),
      margin: const EdgeInsets.all(0),
      color: colorScheme.surfaceContainerLow.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Name and describe your bot',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Bot Name label
            const Text(
              'Bot Name *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            // Bot Name input
            TextField(
              decoration: InputDecoration(
                hintText: 'e.g., Customer Support Assistant',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withAlpha(140),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh
                    .withAlpha(120),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppBorderRadius.medium,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Description label
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            // Description input
            TextField(
              decoration: InputDecoration(
                hintText: 'What does this bot do?',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withAlpha(140),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh
                    .withAlpha(120),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppBorderRadius.medium,
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 16),

            // Category label and AI model
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category *',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      CategoryOptionMenu(
                        onChanged: (category) {
                          // Handle category change if needed
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                // AI Model dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Model *',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      AiModelOptionMenu(
                        onChanged: (model) {
                          // Handle model change if needed
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}