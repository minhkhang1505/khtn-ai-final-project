import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/ai_model_option_menu.dart';

class AiModelCard extends StatelessWidget {
  const AiModelCard({
    super.key,
    required this.onChanged,
    this.errorText,
    this.initialModel,
    this.isReadOnly = false,
  });
  final ValueChanged<String> onChanged;
  final String? errorText;
  final String? initialModel;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.medium,
        side: BorderSide(
          color: colorScheme.outlineVariant.withAlpha(100),
          width: 1.5,
        ),
      ),
      margin: const EdgeInsets.all(0),
      color: colorScheme.surfaceContainerLow.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Model',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              isReadOnly
                  ? 'AI model (cannot be changed after creation)'
                  : 'Select the AI model for your bot (It can not be changed later)',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            AiModelOptionMenu(
              onChanged: onChanged,
              initialModel: initialModel,
              isReadOnly: isReadOnly,
            ),

            if (errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                errorText!,
                style: TextStyle(color: colorScheme.error, fontSize: 12),
              ),
            ]
          ]
        ),
      ),
    );
  }
}
