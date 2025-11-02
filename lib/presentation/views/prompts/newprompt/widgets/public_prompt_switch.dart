import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class PublicPromptSwitch extends StatelessWidget {
  final bool isPublic;
  final ValueChanged<bool> onChanged;

  const PublicPromptSwitch({
    super.key,
    required this.isPublic,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: AppBorderRadius.large,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Make this prompt public",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                "Allow others to discover this prompt",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Switch(value: isPublic, onChanged: onChanged),
        ],
      ),
    );
  }
}
