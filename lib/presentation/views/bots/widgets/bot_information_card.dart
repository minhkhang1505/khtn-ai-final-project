import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class BotInformationCard extends StatelessWidget {
  const BotInformationCard({
    super.key,
    this.assistantNameController,
    this.instructionsController,
    this.descriptionController,
    this.assistantNameError,
  });

  final TextEditingController? assistantNameController;
  final TextEditingController? instructionsController;
  final TextEditingController? descriptionController;
  final String? assistantNameError;

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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            // Bot Name input
            TextField(
              controller: assistantNameController,
              decoration: InputDecoration(
                hintText: 'e.g., Customer Support Assistant',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withAlpha(140),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh.withAlpha(120),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppBorderRadius.medium,
                  borderSide: BorderSide(
                    color: assistantNameError != null
                        ? colorScheme.error
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppBorderRadius.medium,
                  borderSide: BorderSide(
                    color: assistantNameError != null
                        ? colorScheme.error
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: AppBorderRadius.medium,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            if (assistantNameError != null) ...[
              const SizedBox(height: 6),
              Text(
                assistantNameError!,
                style: TextStyle(
                  color: colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ],
            const SizedBox(height: 16),

            // Instructions label
            const Text(
              'Instructions (optional)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            // Instructions input
            TextField(
              controller: instructionsController,
              decoration: InputDecoration(
                hintText: 'Describe how your bot should behave and respond.',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withAlpha(140),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh.withAlpha(120),
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

            // Description label
            const Text(
              'Description (optional)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            // Description input
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'A brief description for your bot. (optional)',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withAlpha(140),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh.withAlpha(120),
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
          ],
        ),
      ),
    );
  }
}
