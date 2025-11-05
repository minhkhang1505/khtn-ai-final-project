import 'package:flutter/material.dart';
import '../widgets/agents_card.dart' ;
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart'
    show AppSpacing;

class ActiveAgentsTab extends StatelessWidget {
  const ActiveAgentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final agents = AgentModel.createSampleAgents()
        .map((agent) => AgentCard(agent: agent))
        .toList();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.vertical,
        horizontal: AppSpacing.horizontal,
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.cardSpacing),
      itemCount: 10,
      itemBuilder: (context, index) {
        return agents[index % agents.length];
      },
    );
  }
}
