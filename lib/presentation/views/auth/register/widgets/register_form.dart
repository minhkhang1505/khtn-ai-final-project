import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/auth_view_model.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/google_auth_button.dart';
import '../../widgets/auth_prompt.dart';
import '../../widgets/auth_primary_button.dart';
import 'terms_checkbox.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool? isTermsChecked;
  final ValueChanged<bool?> onTermsChanged;
  final VoidCallback onCreateAccount;
  final VoidCallback onGoogleSignUp;
  final VoidCallback onSignInTap;
  final AuthViewModel error;

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
    required this.error,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _obscureText = false; // Start with password hidden
  bool _obscureConfirmText = false; // Start with confirm password hidden

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
            controller: widget.fullNameController,
            keyboardType: TextInputType.name,
            error: widget.error.fullNameError,
          ),
          AuthTextField(
            label: "Email",
            hintText: "abc@example.com",
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            error: widget.error.emailError,
          ),
          AuthTextField(
            label: "Password",
            hintText: "********",
            controller: widget.passwordController,
            obscureText: _obscureText,
            onChanged: (value) {},
            suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
            onSuffixIconPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            error: widget.error.passwordError,
          ),
          AuthTextField(
            label: "Confirm Password",
            hintText: "********",
            controller: widget.confirmPasswordController,
            obscureText: _obscureConfirmText,
            suffixIcon: _obscureConfirmText
                ? Icons.visibility
                : Icons.visibility_off,
            onSuffixIconPressed: () {
              setState(() {
                _obscureConfirmText = !_obscureConfirmText;
              });
            },
            error: widget.error.confirmPasswordError,
          ),
          TermsCheckbox(
            isChecked: widget.isTermsChecked,
            onChanged: widget.onTermsChanged,
          ),
          AuthPrimaryButton(
            onPressed: widget.onCreateAccount,
            text: "Create Account",
          ),
          const AuthDivider(),
          GoogleAuthButton(
            onPressed: widget.onGoogleSignUp,
            text: "Sign in with Google",
          ),
          AuthPrompt(
            question: "Already have an account?",
            actionText: "Sign In",
            onActionTap: widget.onSignInTap,
          ),
        ],
      ),
    );
  }
}
