import 'package:flutter/material.dart';

class AuthPrompt extends StatelessWidget {
  final String question;
  final String actionText;
  final VoidCallback onActionTap;

  const AuthPrompt({
    super.key,
    required this.question,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
