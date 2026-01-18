import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'favorite_button_toggle.dart';

class BotActionCard extends StatelessWidget {
  final dynamic bot;
  final VoidCallback? onCanceled;
  final VoidCallback? onDeleted;
  final VoidCallback? onFavoriteToggle;
  final ValueNotifier<bool>? isFavoriteNotifier;

  const BotActionCard({
    super.key,
    required this.bot,
    this.onDeleted,
    this.onCanceled,
    this.onFavoriteToggle,
    this.isFavoriteNotifier,
  });

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
      color: colorScheme.surfaceContainerLow.withAlpha(10),
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: FavoriteButtonToggle(
                      isFavoriteNotifier:
                          isFavoriteNotifier ?? ValueNotifier<bool>(false),
                      onToggle: onFavoriteToggle,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (onDeleted != null) {
                          onDeleted!();
                        }
                      },
                      icon: const Icon(Icons.delete_outline, size: 20),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error,
                        foregroundColor: colorScheme.onError,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppBorderRadius.medium,
                        ),
                        padding: EdgeInsets.zero,
                        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
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
