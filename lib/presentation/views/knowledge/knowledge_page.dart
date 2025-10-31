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

class FilterChipMenu extends StatefulWidget {
  @override
  State<FilterChipMenu> createState() => _FilterChipMenuState();
}

class _FilterChipMenuState extends State<FilterChipMenu> {
  String selected = 'All';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<String>(
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.filter_list),
                  title: Text('All'),
                  onTap: () {
                    Navigator.pop(context, "All");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Created time'),
                  onTap: () {
                    Navigator.pop(context, "Created time");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('Ascending'),
                  onTap: () {
                    Navigator.pop(context, "Ascending");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('Descending'),
                  onTap: () {
                    Navigator.pop(context, "Descending");
                  },
                ),
              ],
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
            Icon(Icons.filter_list, size: 16),
            SizedBox(width: 8),
            Text(selected),
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
