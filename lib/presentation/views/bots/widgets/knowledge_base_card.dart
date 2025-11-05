import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class KnowledgeBaseCard extends StatelessWidget {
  const KnowledgeBaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.medium,
        side: BorderSide(
          color: colorScheme.outlineVariant.withAlpha(150),
          width: 1.5,
        ),
      ),
      margin: const EdgeInsets.all(0),
      color: colorScheme.surfaceContainerLow.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              'Knowledge Base',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),

            const Text(
              "Enhance your bot’s intelligence by adding relevant knowledge sources.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Upload Button
            SizedBox(
              width: double
                  .infinity, // chiếm full chiều ngang của card
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle file upload
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Documents'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.surfaceContainerHigh,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.small,
                    side: BorderSide(color: colorScheme.outline),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}