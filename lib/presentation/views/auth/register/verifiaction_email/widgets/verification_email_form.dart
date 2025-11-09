import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_primary_button.dart';
import 'package:khtn_ai_final_project/presentation/views/auth/widgets/auth_prompt.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class VerificationEmailForm extends StatelessWidget {
  final Function(String) onVerifyAndContinue;
  final Function(String)? onCodeChanged;
  final VoidCallback onResendCode;
  final VoidCallback onChangeEmail;
  final VoidCallback onVerifyAndContinueButton;

  const VerificationEmailForm({
    super.key,
    this.onCodeChanged,
    required this.onResendCode,
    required this.onChangeEmail,
    required this.onVerifyAndContinue,
    required this.onVerifyAndContinueButton,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 400,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Enter your verification code",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text("Please enter the 6-digit code to confirm your email address"),
          OtpTextField(
            numberOfFields: 6,
            borderColor: colorScheme.primary,
            showFieldAsBox: false,
            onCodeChanged: onCodeChanged,
            onSubmit: onVerifyAndContinue,
          ),
          AuthPrompt(
            question: "Didn't receive the code?",
            actionText: "Resend",
            onActionTap: onResendCode,
          ),
          AuthPrimaryButton(
            onPressed: onVerifyAndContinueButton,
            text: "Verify & Continue",
          ),
          TextButton(
            onPressed: onChangeEmail,
            child: Text("Change Email Address"),
          ),
        ],
      ),
    );
  }
}
