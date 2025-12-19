import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/core/utils/icon_ai_model_helper.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';

class AiModelOptionMenu extends StatefulWidget {
  final Function(String)? onChanged;
  const AiModelOptionMenu({super.key, this.onChanged});

  @override
  State<AiModelOptionMenu> createState() => _AiModelOptionMenuState();
}

class _AiModelOptionMenuState extends State<AiModelOptionMenu> {
  late final List<Map<String, String>> models;

  String? selectedModel;

  @override
  void initState() {
    super.initState();
    models = AssistantModelType.values
        .map((m) => {'id': m.id, 'label': m.name})
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
      color: colorScheme.surface,
      elevation: 6,
      offset: const Offset(0, 40),
      onSelected: (index) {
        final model = models[index];
        setState(() {
          selectedModel = model['id'];
        });
        widget.onChanged?.call(model['id']!);
      },
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.3,
      ),
      itemBuilder: (context) => List.generate(
        models.length,
        (index) => PopupMenuItem<int>(
          value: index,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    IconAiModelHelper.iconForModel(models[index]['id']!),
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
        width: double.infinity,
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

                if (selectedModel != null)
                  Icon(
                    IconAiModelHelper.iconForModel(selectedModel!),
                    size: 20,
                  ),
                const SizedBox(width: 8),
                Text(
                  selectedModel == null
                      ? "Select Model"
                      : models.firstWhere((m) => m['id'] == selectedModel)['label']!,
                  style: TextStyle(
                    color: selectedModel == null
                        ? colorScheme.onSurfaceVariant
                        : colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(width: 8),
              ],
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
