import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

/// Section for appearance settings
class AppearanceSection extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool>? onThemeChanged;

  const AppearanceSection({
    super.key,
    required this.isDarkMode,
    this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(150),
          width: 1.5,
        ),
        color: colorScheme.surfaceContainerLow,
        borderRadius: AppBorderRadius.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Appearance",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dark Mode", style: TextStyle(fontSize: 14)),
                  Text(
                    "Toggle dark mode theme",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Switch(value: isDarkMode, onChanged: onThemeChanged),
            ],
          ),
        ],
      ),
    );
  }
}
