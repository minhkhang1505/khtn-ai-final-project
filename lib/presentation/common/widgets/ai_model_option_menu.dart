import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/core/utils/ai_model_icon_helper.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/create_bot_view_model.dart';

class AiModelOptionMenu extends StatelessWidget {
  final bool isReadOnly;
  final String? fixedModelId; // For read-only display

  const AiModelOptionMenu({
    super.key,
    this.isReadOnly = false,
    this.fixedModelId,
  });

  static final List<Map<String, String>> models = AssistantModelType.values
      .map((m) => {'id': m.id, 'label': m.name})
      .toList();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isEnabled = !isReadOnly;

    // Get selected model - from viewmodel if editable, or from fixedModelId if readonly
    final String selectedModel;
    if (isReadOnly) {
      selectedModel = fixedModelId ?? AssistantModelType.GPT_4O_MINI.id;
    } else {
      final viewModel = context.watch<CreateBotViewModel>();
      selectedModel =
          viewModel.selectedModelId ?? AssistantModelType.GPT_4O_MINI.id;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final menuWidth = constraints.maxWidth;

        return PopupMenuButton<int>(
          enabled: isEnabled,
          shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
          color: colorScheme.surface,
          elevation: 6,
          offset: const Offset(0, 40),
          onSelected: (index) {
            if (!isReadOnly) {
              final model = models[index];
              final viewModel = context.read<CreateBotViewModel>();
              viewModel.setSelectedModel(model['id']!);
            }
          },
          constraints: BoxConstraints(minWidth: menuWidth, maxWidth: menuWidth),
          itemBuilder: (context) => List.generate(
            models.length,
            (index) => PopupMenuItem<int>(
              value: index,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AiModelIconHelper.iconForModel(
                        models[index]['id']!,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(models[index]['label']!),
                    ],
                  ),
                  if (selectedModel == models[index]['id'])
                    Icon(Icons.check, color: colorScheme.primary, size: 18),
                ],
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: menuWidth,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              borderRadius: AppBorderRadius.medium,
              border: Border.all(color: colorScheme.outline.withAlpha(100)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AiModelIconHelper.iconForModel(selectedModel, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      models.firstWhere(
                        (m) => m['id'] == selectedModel,
                      )['label']!,
                      style: TextStyle(color: colorScheme.onSurface),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                if (!isReadOnly) const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        );
      },
    );
  }
}
