import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? iconPath;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        const SizedBox(height: 40),
        SvgPicture.asset(
          iconPath ?? "assets/icons/ic_ai_star.svg",
          width: 60,
          height: 60,
          colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        Text(subtitle),
        const SizedBox(height: 30),
      ],
    );
  }
}
