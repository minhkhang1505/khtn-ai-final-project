import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
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
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Full name cannot be empty";
              }
              if (value.length < 3) {
                return "Full name must be at least 3 characters";
              }
              return null;
            },
          ),
          AuthTextField(
            label: "Email",
            hintText: "abc@example.com",
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email cannot be empty";
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return "Invalid email format";
              }
              return null;
            },
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              }
              if (value.length < 8) {
                return "Password must be at least 8 characters";
              }
              return null;
            },
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
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Confirm Password cannot be empty";
              }
              if (value != widget.passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
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
