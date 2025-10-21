import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';

class AuthBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AuthBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.extraExtraLarge,
          color: colorScheme.primary.withValues(alpha: 0.2),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.chevron_left, size: 30, color: colorScheme.primary),
      ),
    );
  }
}
