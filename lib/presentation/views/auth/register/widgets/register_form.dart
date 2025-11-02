import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/google_auth_button.dart';
import '../../widgets/auth_prompt.dart';
import '../../widgets/auth_primary_button.dart';
import 'terms_checkbox.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool? isTermsChecked;
  final ValueChanged<bool?> onTermsChanged;
  final VoidCallback onCreateAccount;
  final VoidCallback onGoogleSignUp;
  final VoidCallback onSignInTap;

  const RegisterForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isTermsChecked,
    required this.onTermsChanged,
    required this.onCreateAccount,
    required this.onGoogleSignUp,
    required this.onSignInTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 680,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: AppBorderRadius.extraLarge,
        boxShadow: [
          BoxShadow(
            color: colorScheme.outline.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            label: "Full name",
            hintText: "John Doe",
            controller: fullNameController,
            keyboardType: TextInputType.name,
            onChanged: (value) {},
          ),
          AuthTextField(
            label: "Email",
            hintText: "abc@example.com",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {},
          ),
          AuthTextField(
            label: "Password",
            hintText: "********",
            controller: passwordController,
            obscureText: true,
            onChanged: (value) {},
          ),
          AuthTextField(
            label: "Confirm Password",
            hintText: "********",
            controller: confirmPasswordController,
            obscureText: true,
            onChanged: (value) {},
          ),
          TermsCheckbox(isChecked: isTermsChecked, onChanged: onTermsChanged),
          AuthPrimaryButton(onPressed: onCreateAccount, text: "Create Account"),
          const AuthDivider(),
          GoogleAuthButton(
            onPressed: onGoogleSignUp,
            text: "Sign in with Google",
          ),
          AuthPrompt(
            question: "Already have an account?",
            actionText: "Sign In",
            onActionTap: onSignInTap,
          ),
        ],
      ),
    );
  }
}
