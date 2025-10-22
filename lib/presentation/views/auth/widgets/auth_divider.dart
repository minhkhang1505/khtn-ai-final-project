import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  final String text;

  const AuthDivider({super.key, this.text = "Or continue with"});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 1, child: Divider()),
        Text("  $text  "),
        const Expanded(flex: 1, child: Divider()),
      ],
    );
  }
}
