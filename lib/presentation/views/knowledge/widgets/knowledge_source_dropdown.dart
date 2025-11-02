import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/domain/models/knowledge_source_type.dart';

/// A reusable dropdown widget for selecting knowledge source types
class KnowledgeSourceDropdown extends StatelessWidget {
  final TextEditingController controller;
  final KnowledgeSourceType? initialSelection;
  final ValueChanged<KnowledgeSourceType?>? onSelected;

  const KnowledgeSourceDropdown({
    super.key,
    required this.controller,
    this.initialSelection,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Source: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        DropdownMenu<KnowledgeSourceType>(
          controller: controller,
          enableFilter: true,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
          ),
          initialSelection: initialSelection ?? KnowledgeSourceTypes.all[0],
          requestFocusOnTap: true,
          onSelected: onSelected,
          dropdownMenuEntries: KnowledgeSourceTypes.all.map((source) {
            return DropdownMenuEntry<KnowledgeSourceType>(
              value: source,
              label: source.name,
              leadingIcon: SvgPicture.asset(
                source.iconAssetPath,
                width: 24,
                height: 24,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
