import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/custom_back_button.dart';

/// Auth-specific back button
/// This is a convenience wrapper around CustomBackButton for auth screens
class AuthBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AuthBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomBackButton(onPressed: onPressed);
  }
}
