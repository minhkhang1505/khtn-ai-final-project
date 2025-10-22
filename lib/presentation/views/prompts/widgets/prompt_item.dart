import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';

class PromptItem extends StatelessWidget {
  final Prompt prompt;
  final VoidCallback? onFavoriteTap;

  const PromptItem({super.key, required this.prompt, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.large,
        border: Border.all(color: colorScheme.outline),
        color: colorScheme.surfaceContainerLow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prompt.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (prompt.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        prompt.description!,
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: onFavoriteTap,
                      icon: Icon(
                        prompt.isFavorite ? Icons.star : Icons.star_border,
                        color: prompt.isFavorite
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
