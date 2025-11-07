import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class AgentInformationCard extends StatelessWidget {
  const AgentInformationCard({super.key});

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
              'Name and describe your agent',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Agent Name label
            const Text(
              'Agent Name *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            // Agent Name input
            TextField(
              decoration: InputDecoration(
                hintText: 'e.g., Email Assistant',
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
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            // Description input
            TextField(
              decoration: InputDecoration(
                hintText: 'What does this agent do?',
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
          ],
        ),
      ),
    );
  }
}