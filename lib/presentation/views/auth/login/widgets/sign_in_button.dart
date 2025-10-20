import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        "Sign In",
        style: TextStyle(fontSize: 16, color: colorScheme.onPrimary),
      ),
      icon: Icon(Icons.arrow_forward, color: colorScheme.onPrimary),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        backgroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.large),
      ),
    );
  }
}
