import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class AiModelOptionMenu extends StatefulWidget {
  final Function(String)? onChanged;
  const AiModelOptionMenu({super.key, this.onChanged});

  @override
  State<AiModelOptionMenu> createState() => _AiModelOptionMenuState();
}

class _AiModelOptionMenuState extends State<AiModelOptionMenu> {
  final List<String> models = [
    'GPT-3.5',
    'GPT-4',
    'Claude',
    'Claude 2',
    'Bard',
    'Llama 3',
  ];

  String? selectedModel;

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
          selectedModel = model;
        });
        widget.onChanged?.call(model);
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
              Text(models[index]),
              if (selectedModel == models[index])
                const Icon(Icons.check, color: Colors.blue, size: 18),
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
            Text(
              selectedModel ?? "Select Model",
              style: TextStyle(
                color: selectedModel == null
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
