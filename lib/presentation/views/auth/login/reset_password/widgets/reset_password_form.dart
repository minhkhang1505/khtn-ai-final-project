import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_primary_button.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_text_field.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class ResetPasswordForm extends StatelessWidget {
  final VoidCallback onSubmit;
  const ResetPasswordForm({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 380,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: AppBorderRadius.extraLarge,
        boxShadow: [
          BoxShadow(
            color: colorScheme.outline.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Enter your new password below",
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
          ),
          AuthTextField(label: "New Password", hintText: "********"),
          AuthTextField(label: "Confirm New Password", hintText: "********"),
          AuthPrimaryButton(onPressed: onSubmit, text: "Continue"),
        ],
      ),
    );
  }
}
