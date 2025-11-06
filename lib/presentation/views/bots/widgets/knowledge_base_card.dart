import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/expanded_button.dart';

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
            ExpandedButton(onPressed: () => {}, icon: const Icon(Icons.upload_file), label: 'Upload Documents'),
            const SizedBox(height: 16),

            // Links
            const Text(
              'Url Links',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            TextField(
              decoration: InputDecoration(
                hintText: 'https://example.com/knowledge-base',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withAlpha(140),
                  fontSize: 14,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh.withAlpha(120),
                border: OutlineInputBorder(
                  borderRadius: AppBorderRadius.medium,
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.add_link,
                    color: colorScheme.primary,
                  ),
                  onPressed: () {
                    // TODO: Handle link addition
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Cloud Storage Options
            const Text(
              'Cloud Storage Options',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            ExpandedButton(onPressed: () {}, icon: const Icon(Icons.cloud_upload_outlined), label: 'Google Drive'),
            const SizedBox(height: 12),

            ExpandedButton(onPressed: () {}, icon: const Icon(Icons.cloud_upload_outlined), label: 'Slack'),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}