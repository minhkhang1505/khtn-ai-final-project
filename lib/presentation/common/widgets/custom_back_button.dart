import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;
  final IconData icon;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;

  const CustomBackButton({
    this.margin = const EdgeInsets.all(0.0),
    super.key,
    this.onPressed,
    this.icon = Icons.chevron_left,
    this.size = 30,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.extraExtraLarge,
          color: backgroundColor ?? colorScheme.primary.withValues(alpha: 0.2),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: size, color: iconColor ?? colorScheme.primary),
      ),
    );
  }
}
