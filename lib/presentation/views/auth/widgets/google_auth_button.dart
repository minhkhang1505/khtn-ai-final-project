import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';

class GoogleAuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const GoogleAuthButton({
    super.key,
    required this.onPressed,
    this.text = "Sign in with Google",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: AppBorderRadius.large,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/ic_google.svg",
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 4),
            Text(" $text", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
