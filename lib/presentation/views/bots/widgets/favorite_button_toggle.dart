import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class FavoriteButtonToggle extends StatelessWidget {
  final ValueNotifier<bool> isFavoriteNotifier;
  final VoidCallback? onToggle;

  const FavoriteButtonToggle({
    super.key,
    required this.isFavoriteNotifier,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFavoriteNotifier,
      builder: (context, isFavorite, child) {
        final colorScheme = Theme.of(context).colorScheme;
        
        return OutlinedButton.icon(
          onPressed: onToggle,
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          label: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: AppBorderRadius.medium,
            ),
            side: BorderSide(
              color: isFavorite ? colorScheme.primary : colorScheme.outline,
              width: isFavorite ? 2 : 1,
            ),
            foregroundColor: isFavorite ? colorScheme.primary : null,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
          ),
        );
      },
    );
  }
}
