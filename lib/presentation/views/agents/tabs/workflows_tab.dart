import 'package:flutter/material.dart';
import '../widgets/workflow_card.dart';
import 'package:khtn_ai_final_project/data/models/workflow_model.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart' show AppSpacing;

/// Tab to display workflows associated with AI agents
class WorkflowsTab extends StatelessWidget {
  const WorkflowsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.vertical,
        horizontal: AppSpacing.horizontal,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WorkflowsCard(workflowType: Workflow.emailTriage),
            const SizedBox(height: AppSpacing.cardSpacing),
            WorkflowsCard(workflowType: Workflow.dataExtraction),
            const SizedBox(height: AppSpacing.cardSpacing),
            WorkflowsCard(workflowType: Workflow.dataExtraction),
          ],
        ),
      ),
    );
  }
}
