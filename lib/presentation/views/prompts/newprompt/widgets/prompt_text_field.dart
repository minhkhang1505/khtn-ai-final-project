import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class PromptTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  const PromptTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    this.controller,
    this.onChanged,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: colorScheme.onSurface.withAlpha(140)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: colorScheme.surfaceContainerHigh.withAlpha(120),
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: AppBorderRadius.medium,
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.medium,
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
