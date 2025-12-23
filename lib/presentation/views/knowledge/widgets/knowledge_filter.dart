import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge_base_viewmodel.dart';
import 'package:provider/provider.dart';

class KnowledgeFilter {
  final String id;
  final String label;
  final String iconPath;

  const KnowledgeFilter({
    required this.id,
    required this.label,
    required this.iconPath,
  });
}

const List<KnowledgeFilter> knowledgeFilters = [
  KnowledgeFilter(id: 'all', label: 'All', iconPath: 'assets/icons/ic_all.svg'),
  KnowledgeFilter(
    id: 'createdAt',
    label: 'Created Time',
    iconPath: 'assets/icons/ic_created_at.svg',
  ),
  KnowledgeFilter(
    id: 'ascending',
    label: 'Ascending',
    iconPath: 'assets/icons/ic_ascending.svg',
  ),
  KnowledgeFilter(
    id: 'descending',
    label: 'Descending',
    iconPath: 'assets/icons/ic_descending.svg',
  ),
];

class FilterChipMenu extends StatefulWidget {
  const FilterChipMenu({super.key});
  @override
  State<FilterChipMenu> createState() => _FilterChipMenuState();
}

class _FilterChipMenuState extends State<FilterChipMenu> {
  KnowledgeFilter selected = knowledgeFilters.first;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Capture viewmodel before opening bottom sheet
        final vm = context.read<KnowledgeBaseViewmodel>();

        final result = await showModalBottomSheet<KnowledgeFilter>(
          context: context,
          builder: (bottomSheetContext) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: knowledgeFilters.map((filter) {
                return ListTile(
                  leading: SvgPicture.asset(
                    filter.iconPath,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(bottomSheetContext).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(filter.label),
                  onTap: () {
                    Navigator.of(bottomSheetContext).pop(filter);
                  },
                );
              }).toList(),
            ),
          ),
        );
        if (result != null && mounted) {
          await _handleFilterChange(result, vm);
        }
      },
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              selected.iconPath,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8),
            Text(selected.label),
          ],
        ),
      ),
    );
  }

  Future<void> _handleFilterChange(
    KnowledgeFilter newFilter,
    KnowledgeBaseViewmodel vm,
  ) async {
    setState(() => selected = newFilter);

    try {
      if (newFilter.id == 'all') {
        await vm.refreshKnowledges();
      } else if (newFilter.id == 'createdAt') {
        await vm.sortKnowledgesByField('createdAt');
      } else if (newFilter.id == 'ascending') {
        await vm.sortKnowledgesBy(KnowledgeOrder.ASC);
      } else if (newFilter.id == 'descending') {
        await vm.sortKnowledgesBy(KnowledgeOrder.DESC);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}
