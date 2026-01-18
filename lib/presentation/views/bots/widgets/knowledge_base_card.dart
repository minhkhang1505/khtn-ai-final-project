import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/expanded_button.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/knowledge_item.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/edit_bot_view_model.dart';

class KnowledgeBaseCard extends StatelessWidget {
  const KnowledgeBaseCard({
    super.key,
    this.knowledges = const [],
    this.isLoading = false,
    this.onAddKnowledge,
  });

  final List<KnowledgeResDto> knowledges;
  final bool isLoading;
  final VoidCallback? onAddKnowledge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.medium,
        side: BorderSide(
          color: colorScheme.outlineVariant.withAlpha(100),
          width: 1.5,
        ),
      ),
      margin: const EdgeInsets.all(0),
      color: colorScheme.surfaceContainerLow.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Knowledge Base',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 4),

            const Text(
              "Enhance your bot’s intelligence by adding relevant knowledge sources.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            else if (knowledges.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  'No knowledge linked to this bot yet.',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = knowledges[index];
                  return KnowledgeItem(
                    iconPath: 'assets/icons/ic_knowledge.svg',
                    knowledge: KnowledgeEntity(
                      id: item.id,
                      userId: item.userId,
                      knowledgeName: item.knowledgeName,
                      description: item.description,
                      createdAt: item.createdAt,
                      updatedAt: item.updatedAt,
                      createdBy: item.createdBy,
                      updatedBy: item.updatedBy,
                    ),
                    onDelete: () async {
                      final vm = context.read<EditBotViewModel>();
                      final scaffold = ScaffoldMessenger.of(context);
                      final success = await vm.removeKnowledgeFromBot(item.id);
                      if (success) {
                        scaffold.showSnackBar(
                          const SnackBar(
                            content: Text('Knowledge removed successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        scaffold.showSnackBar(
                          SnackBar(
                            content: Text(
                              vm.errorMessage ?? 'Failed to remove knowledge',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 12,
                  color: colorScheme.outlineVariant.withAlpha(70),
                ),
                itemCount: knowledges.length,
              ),

            const SizedBox(height: 16),

            ExpandedButton(
              icon: Icon(Icons.add),
              label: 'Add knowledge',
              onPressed: onAddKnowledge ?? () {},
            ),
          ],
        ),
      ),
    );
  }
}
