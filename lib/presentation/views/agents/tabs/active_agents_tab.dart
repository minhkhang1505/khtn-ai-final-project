import 'package:flutter/material.dart';
import '../widgets/agents_card.dart' ;
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class ActiveAgentsTab extends StatelessWidget {
  const ActiveAgentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final agents = AgentModel.createSampleAgents()
        .map((agent) => InkWell(
          borderRadius: AppBorderRadius.medium,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/agents/edit',
              arguments: agent,
            );
          },
          child: AgentCard(agent: agent),
        ),)
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
