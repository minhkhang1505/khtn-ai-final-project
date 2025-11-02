import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/login/reset_password/widgets/reset_password_form.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_back_button.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_header.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  void _handleResetPasswordButton() {
    // Handle reset password logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(children: [AuthBackButton(onPressed: () {})]),
                  AuthHeader(
                    iconPath: "assets/icons/ic_lock_password.svg",
                    title: "Reset Your Password",
                    subtitle: "",
                  ),
                  ResetPasswordForm(onSubmit: _handleResetPasswordButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
