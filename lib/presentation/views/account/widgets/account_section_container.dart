import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

/// Reusable container widget for account sections
class AccountSectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const AccountSectionContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(150),
          width: 1.5,
        ),
        color: colorScheme.surfaceContainerLow,
        borderRadius: AppBorderRadius.large,
      ),
      child: child,
    );
  }
}
