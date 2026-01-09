import 'package:flutter/material.dart';
import '../widgets/workflow_card.dart';
import 'package:khtn_ai_final_project/data/models/workflow_model.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart'
    show AppSpacing;

/// Tab to display workflows associated with AI agents
class WorkflowsTab extends StatelessWidget {
  const WorkflowsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSpacing.vertical,
        left: AppSpacing.horizontal,
        right: AppSpacing.horizontal,
        bottom: 100,
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
