import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class PromptItem extends StatelessWidget {
  final Prompt prompt;
  final VoidCallback? onFavoriteTap;
  final VoidCallback onTap;

  const PromptItem({
    super.key,
    required this.prompt,
    this.onFavoriteTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.large,
          border: Border.all(
            color: colorScheme.outline.withAlpha(50),
            width: 1.5,
          ),
          color: colorScheme.surfaceContainerLow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 17,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // public status
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: AppBorderRadius.extraLargeIncreased,
                            ),
                            child: Text(
                              prompt.isPublic ? "Public" : "Private",
                              style: TextStyle(color: colorScheme.onPrimary),
                            ),
                          ),
                          const SizedBox(width: 4),

                          // title
                          Expanded(
                            child: Text(
                              prompt.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // description
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: onFavoriteTap,
                        icon: Icon(
                          prompt.isFavorite ? Icons.star : Icons.star_border,
                          color: prompt.isFavorite
                              ? Colors.amber
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (prompt.description != null) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  prompt.description!,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.onPrimaryFixedVariant),
                color: colorScheme.primaryContainer.withAlpha(20),
                borderRadius: AppBorderRadius.extraLargeIncreased,
              ),
              child: Text(prompt.category),
            ),
          ],
        ),
      ),
    );
  }
}
