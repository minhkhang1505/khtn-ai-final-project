import 'package:flutter/material.dart';

class KnowledgeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddKnowledge;

  const KnowledgeAppBar({super.key, required this.onAddKnowledge});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Knowledge'),
              SizedBox(height: 4),
              Text('Connect data sources', style: TextStyle(fontSize: 14)),
            ],
          ),
          IconButton(onPressed: onAddKnowledge, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
