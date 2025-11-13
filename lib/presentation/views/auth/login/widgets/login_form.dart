import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/google_auth_button.dart';
import '../../widgets/auth_prompt.dart';
import '../../widgets/auth_primary_button.dart';
import 'remember_me_row.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final bool isRememberMeChecked;
  final ValueChanged<bool> onRememberMeChanged;
  final VoidCallback onForgotPassword;
  final VoidCallback onSignIn;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onSignUpTap;

  const LoginForm({
    super.key,
    this.emailController,
    this.passwordController,
    required this.isRememberMeChecked,
    required this.onRememberMeChanged,
    required this.onForgotPassword,
    required this.onSignIn,
    required this.onGoogleSignIn,
    required this.onSignUpTap,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true; // Start with password hidden

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 520,
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
          // Text description
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("Enter your credentials to access your account"),
            ],
          ),
          // Email field
          AuthTextField(
            label: "Email",
            hintText: "John@example.com",
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
          // Password field
          AuthTextField(
            label: "Password",
            hintText: "Enter your password",
            controller: widget.passwordController,
            obscureText: _obscureText,
            onChanged: (value) {},
            onSuffixIconPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
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
          // Remember me and Forgot password
          RememberMeRow(
            isChecked: widget.isRememberMeChecked,
            onChanged: widget.onRememberMeChanged,
            onForgotPassword: widget.onForgotPassword,
          ),
          // Sign In button
          AuthPrimaryButton(onPressed: widget.onSignIn, text: "Sign In"),
          // Divider
          const AuthDivider(text: "Or continue with"),
          // Google Sign In button
          GoogleAuthButton(onPressed: widget.onGoogleSignIn),
          // Sign up prompt
          AuthPrompt(
            question: "Don't have an account?",
            actionText: "Sign up",
            onActionTap: widget.onSignUpTap,
          ),
        ],
      ),
    );
  }
}
