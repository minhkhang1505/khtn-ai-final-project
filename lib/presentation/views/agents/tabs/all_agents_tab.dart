import 'package:flutter/material.dart';
import '../widgets/agents_card.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

/// Tab to display all AI agents
class AllAgentsTab extends StatelessWidget {
  const AllAgentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final allAgents = AgentModel.createSampleAgents();
    final agents = allAgents
        .map(
          (agent) => InkWell(
            borderRadius: AppBorderRadius.medium,
            onTap: () {
              if (agent.status == 'Active') {
                Navigator.pushNamed(context, '/agents/chat', arguments: agent);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This agent do not support now'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: AgentCard(agent: agent),
          ),
        )
        .toList();

    return ListView.separated(
      padding: const EdgeInsets.only(
        top: AppSpacing.vertical - 4,
        left: AppSpacing.horizontal - 4,
        right: AppSpacing.horizontal - 4,
        bottom: 96,
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.cardSpacing - 8),
      itemCount: agents.length,
      itemBuilder: (context, index) {
        return agents[index % agents.length];
      },
    );
  }
}
