import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A reusable section header with optional action button
class KnowledgeSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onActionPressed;
  final String? actionIconPath;

  const KnowledgeSectionHeader({
    super.key,
    required this.title,
    this.onActionPressed,
    this.actionIconPath,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        if (onActionPressed != null && actionIconPath != null)
          IconButton(
            onPressed: onActionPressed,
            icon: SvgPicture.asset(
              actionIconPath!,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
      ],
    );
  }
}
