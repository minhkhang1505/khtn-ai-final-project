import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_primary_button.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_prompt.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_text_field.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class ForgotPasswordForm extends StatelessWidget {
  final TextEditingController emailController;
  final VoidCallback onSubmit;
  final VoidCallback onBackToLogin;

  const ForgotPasswordForm({
    super.key,
    required this.emailController,
    required this.onSubmit,
    required this.onBackToLogin,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 340,
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Enter your email address and we'll send you a verification code",
          ),
          SizedBox(height: 1),
          AuthTextField(label: "Email Address", hintText: "you@example.com"),
          AuthPrimaryButton(
            onPressed: onSubmit,
            text: "Send Verification Code",
          ),
          AuthPrompt(
            question: "Remember your password?",
            actionText: "Sign In",
            onActionTap: onBackToLogin,
          ),
        ],
      ),
    );
  }
}
