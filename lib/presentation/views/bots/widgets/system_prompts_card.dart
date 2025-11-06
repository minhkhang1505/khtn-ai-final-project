import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class SystemPromptsCard extends StatelessWidget {
  const SystemPromptsCard({super.key});

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
              'System Prompts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),

            const Text(
              "Define your bot's personality and behavior",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            // System Prompt TextField
            TextField(
              decoration: InputDecoration(
                hintText:
                    'e.g., You are a helpful customer support assistant.',
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
              maxLines: 5,
            ),
            const SizedBox(height: 10),

            // Template Prompts
            OutlinedButton(
              onPressed: () {
                // TODO: Show template prompts selection dialog
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: AppBorderRadius.medium,
                ),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
              ),
              child: Text(
                'Use Template',
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}