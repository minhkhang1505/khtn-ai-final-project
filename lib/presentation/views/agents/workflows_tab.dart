import 'package:flutter/material.dart';
import 'workflows_card.dart' show WorkflowsCart, Workflow;
import 'package:khtn_ai_final_project/core/constants/constant.dart' show AppSpacing;

class WorkflowsTab extends StatelessWidget {
  const WorkflowsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.vertical, horizontal: AppSpacing.horizontal),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WorkflowsCart(workflow: Workflow.emailTriage),
            const SizedBox(height: AppSpacing.cardSpacing),
            WorkflowsCart(workflow: Workflow.dataExtraction),
            const SizedBox(height: AppSpacing.cardSpacing),
            WorkflowsCart(workflow: Workflow.dataExtraction),
          ],
        ),
      ),
    );
  }
}