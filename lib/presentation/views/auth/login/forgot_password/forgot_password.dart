import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/login/forgot_password/widgets/forgot_password_form.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_header.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_back_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendVerificationCode() {
    Navigator.pushNamed(context, '/auth/reset-password');
    // TODO: Implement send verification code logic
  }

  void _handleBackToSignIn() {
    Navigator.pushNamed(context, '/auth/login');
    // TODO: Navigate to sign in page
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWideScreen ? 500 : double.infinity,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              AuthBackButton(onPressed: _handleBackToSignIn),
                            ],
                          ),
                          const AuthHeader(
                            iconPath: "assets/icons/ic_lock_password.svg",
                            title: "Forgot Password?",
                            subtitle:
                                "No worries, we'll send you reset instructions",
                          ),
                          ForgotPasswordForm(
                            emailController: _emailController,
                            onSubmit: _handleSendVerificationCode,
                            onBackToLogin: _handleBackToSignIn,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
