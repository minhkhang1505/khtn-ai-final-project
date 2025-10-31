import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/Knowledge_app_bar.dart';

/// Knowledge page - Knowledge base management
class KnowledgePage extends StatelessWidget {
  const KnowledgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KnowledgeAppBar(onAddKnowledge: () => {}),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              //filter section
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [FilterChipMenu()],
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: 5,
                  itemBuilder: (context, index) => KnowledgeItem(
                    iconPath: 'assets/icons/ic_url.svg',
                    knowledge: KnowledgeModel(
                      id: '1',
                      userId: 'user1',
                      knowledgeName: 'Knowledge 1',
                      description: 'Description 1',
                      createdAt: DateTime.now(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
  @override
  State<FilterChipMenu> createState() => _FilterChipMenuState();
}

class _FilterChipMenuState extends State<FilterChipMenu> {
  KnowledgeFilter selected = knowledgeFilters.first;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<KnowledgeFilter>(
          context: context,
          builder: (context) => Container(
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
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(filter.label),
                  onTap: () {
                    Navigator.pop(context, filter);
                  },
                );
              }).toList(),
            ),
          ),
        );
        if (result != null) {
          setState(() => selected = result);
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
}

class KnowledgeItem extends StatelessWidget {
  final String iconPath;
  final KnowledgeModel knowledge;
  const KnowledgeItem({
    super.key,
    required this.knowledge,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withAlpha(50),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              iconPath,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 6),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                knowledge.knowledgeName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(knowledge.description, style: TextStyle(fontSize: 14)),
              Text(
                'Created at: ${knowledge.createdAt.toLocal()}',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KnowledgeModel {
  final String id;
  final String userId;
  final String knowledgeName;
  final String description;
  final DateTime createdAt;

  // this atribute is optional
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;

  KnowledgeModel({
    required this.id,
    required this.userId,
    required this.knowledgeName,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });
}
