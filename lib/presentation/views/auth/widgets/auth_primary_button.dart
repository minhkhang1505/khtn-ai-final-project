import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';

class AuthPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AuthPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        text,
        style: TextStyle(fontSize: 16, color: colorScheme.onPrimary),
      ),
      icon: Icon(Icons.arrow_forward, color: colorScheme.onPrimary),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.large),
      ),
    );
  }
}
