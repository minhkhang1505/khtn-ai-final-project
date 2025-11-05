import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class CategoryOptionMenu extends StatefulWidget {
  final Function(String)? onChanged;
  const CategoryOptionMenu({super.key, this.onChanged});

  @override
  State<CategoryOptionMenu> createState() => _CategoryOptionMenuState();
}

class _CategoryOptionMenuState extends State<CategoryOptionMenu> {
  final List<String> categories = [
    'General',
    'Customer Support',
    'Sales',
    'HR',
    'Development',
    'Marketing',
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
        final category = categories[index];
        setState(() {
          selectedModel = category;
        });
        widget.onChanged?.call(category);
      },
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.3,
      ),
      itemBuilder: (context) => List.generate(
        categories.length,
        (index) => PopupMenuItem<int>(
          value: index,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(categories[index]),
              if (selectedModel == categories[index])
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
            Expanded(
              child:
            Text(
              selectedModel ?? "Select Category",
              style: TextStyle(
                color: selectedModel == null
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
