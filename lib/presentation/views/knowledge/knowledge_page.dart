import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/Knowledge_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_filter.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_item.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';

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
              // Filter section
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [FilterChipMenu()],
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
                      knowledgeName: 'Knowledge $index',
                      description: 'Description $index',
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
