import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/google_auth_button.dart';
import '../../widgets/auth_prompt.dart';
import 'remember_me_row.dart';
import 'sign_in_button.dart';

class LoginForm extends StatelessWidget {
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
            hintText: "Enter your email",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {},
          ),
          // Password field
          AuthTextField(
            label: "Password",
            hintText: "Enter your password",
            controller: passwordController,
            obscureText: true,
            onChanged: (value) {},
          ),
          // Remember me and Forgot password
          RememberMeRow(
            isChecked: isRememberMeChecked,
            onChanged: onRememberMeChanged,
            onForgotPassword: onForgotPassword,
          ),
          // Sign In button
          SignInButton(onPressed: onSignIn),
          // Divider
          const AuthDivider(text: "Or continue with"),
          // Google Sign In button
          GoogleAuthButton(onPressed: onGoogleSignIn),
          // Sign up prompt
          AuthPrompt(
            question: "Don't have an account?",
            actionText: "Sign up",
            onActionTap: onSignUpTap,
          ),
        ],
      ),
    );
  }
}
