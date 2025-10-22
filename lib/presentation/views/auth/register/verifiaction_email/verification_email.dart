import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/register/verifiaction_email/widgets/verification_email_form.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_header.dart';

class VerificationEmailPage extends StatefulWidget {
  final String email;

  const VerificationEmailPage({super.key, required this.email});

  @override
  State<VerificationEmailPage> createState() => _VerificationEmailPageState();
}

class _VerificationEmailPageState extends State<VerificationEmailPage> {
  String _verificationCode = '';

  void _handleCodeChanged(String code) {
    setState(() {
      _verificationCode = code;
    });
  }

  void _handleVerifyAndContinue(String code) {
    // TODO: Implement verification logic
  }

  void _handleVerifyAndContinueButton() {
    // TODO: Implement verification logic
  }

  void _handleResendCode() {
    // TODO: Implement resend code logic
  }

  void _handleChangeEmail() {
    // TODO: Implement change email logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AuthHeader(
                    iconPath: "assets/icons/ic_email.svg",
                    title: "Verify Your Email",
                    subtitle:
                        "We've sent a verification code to ${widget.email}",
                  ),
                  VerificationEmailForm(
                    onResendCode: _handleResendCode,
                    onChangeEmail: _handleChangeEmail,
                    onVerifyAndContinueButton: _handleVerifyAndContinueButton,
                    onCodeChanged: _handleCodeChanged,
                    onVerifyAndContinue: _handleVerifyAndContinue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
