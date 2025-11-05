import 'package:flutter/material.dart';
import '../widgets/agents_card.dart' show AgentCard;
import 'package:khtn_ai_final_project/core/constants/constants.dart' show AppSpacing;
import 'package:khtn_ai_final_project/data/models/agent_model.dart';

/// Tab to display all AI agents
class AllAgentsTab extends StatelessWidget {
  const AllAgentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final allAgents = AgentModel.createSampleAgents();
    final agents = allAgents
        .map((agent) => AgentCard(agent: agent))
        .toList();
        
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.vertical, horizontal: AppSpacing.horizontal),
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.cardSpacing),
      itemCount: agents.length,
      itemBuilder: (context, index) {
        return agents[index % agents.length];
      },
    );
  }
}
