import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';

class PromptDropdownField<T> extends StatelessWidget {
  final String label;
  final String? hintText;
  final List<DropdownMenuEntry<T>> entries;
  final ValueChanged<T?>? onSelected;
  final T? initialSelection;

  const PromptDropdownField({
    super.key,
    required this.label,
    this.hintText,
    required this.entries,
    this.onSelected,
    this.initialSelection,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        DropdownMenu<T>(
          hintText: hintText ?? "",
          initialSelection: initialSelection,
          onSelected: onSelected,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: AppBorderRadius.medium,
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.medium,
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
          ),
          dropdownMenuEntries: entries,
        ),
      ],
    );
  }
}
