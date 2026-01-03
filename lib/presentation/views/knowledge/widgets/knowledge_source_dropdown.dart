import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/domain/models/knowledge_source_type.dart';

/// A reusable dropdown widget for selecting knowledge source types
class KnowledgeSourceDropdown extends StatelessWidget {
  final TextEditingController controller;
  final DataSourceType? initialSelection;
  final ValueChanged<DataSourceType?>? onSelected;
  final bool enabled;

  const KnowledgeSourceDropdown({
    super.key,
    required this.controller,
    this.initialSelection,
    this.onSelected,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        const Text(
          'Source: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        DropdownMenu<DataSourceType>(
          controller: controller,
          enabled: enabled,
          enableFilter: false,
          requestFocusOnTap: false,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline.withAlpha(50)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline.withAlpha(50)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withAlpha(50),
              ),
            ),
          ),
          initialSelection: initialSelection ?? DataSourceTypes.all[0],
          onSelected: enabled ? onSelected : null,
          dropdownMenuEntries: DataSourceTypes.all.map((source) {
            return DropdownMenuEntry<DataSourceType>(
              value: source,
              label: source.name,
              leadingIcon: SvgPicture.asset(
                source.iconAssetPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
