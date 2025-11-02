import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

/// A reusable card container for knowledge forms
class KnowledgeFormCard extends StatelessWidget {
  final Widget child;

  const KnowledgeFormCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.extraLarge,
        color: colorScheme.surfaceContainerLow,
      ),
      child: child,
    );
  }
}
