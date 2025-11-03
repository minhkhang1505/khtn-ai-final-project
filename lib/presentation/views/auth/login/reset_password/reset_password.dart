import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/login/reset_password/widgets/reset_password_form.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_back_button.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_header.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  void _handleResetPasswordButton() {
    Navigator.pushNamed(context, '/auth/login');
    // Handle reset password logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        children: [
                          Row(
                            children: [
                              AuthBackButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          AuthHeader(
                            iconPath: "assets/icons/ic_lock_password.svg",
                            title: "Reset Your Password",
                            subtitle: "",
                          ),
                          ResetPasswordForm(
                            onSubmit: _handleResetPasswordButton,
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
