import 'package:flutter/material.dart';
import '../widgets/agents_card.dart' show AgentCard;
import 'package:khtn_ai_final_project/core/constants/constant.dart' show AppSpacing;

class AllAgentsTab extends StatelessWidget {
  const AllAgentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final agents = [
      AgentCard(
        agentName: 'Email Assistant',
        agentDescription: 'Handles email workflows automatically.',
        workflows: 'Email Triage',
        state: 'Active',
      ),
      AgentCard(
        agentName: 'Data Extractor',
        agentDescription: 'Extracts data from documents.',
        workflows: 'Data Extraction',
        state: 'Inactive',
      ),
      AgentCard(
        agentName: 'Email Assistant',
        agentDescription: 'Handles email workflows automatically.',
        workflows: 'Email Triage',
        state: 'Active',
      ),
      AgentCard(
        agentName: 'Data Extractor',
        agentDescription: 'Extracts data from documents.',
        workflows: 'Data Extraction',
        state: 'Inactive',
      ),
    ];
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.vertical, horizontal: AppSpacing.horizontal),
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.cardSpacing),
      itemCount: 10,
      itemBuilder: (context, index) {
        return agents[index % agents.length];
      },
    );
  }
}
