import 'package:flutter/material.dart';
import 'workflow_card.dart' show WorkflowsCart;
import 'package:khtn_ai_final_project/data/models/workflow_model.dart'
    show Workflow;
import 'package:khtn_ai_final_project/core/constants/constant.dart'
    show AppSpacing;

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
            WorkflowsCart(workflowType: Workflow.emailTriage),
            const SizedBox(height: AppSpacing.cardSpacing + 6.0),
            WorkflowsCart(workflowType: Workflow.dataExtraction),
            const SizedBox(height: AppSpacing.cardSpacing + 6.0),
            WorkflowsCart(workflowType: Workflow.dataExtraction),
          ],
        ),
      ),
    );
  }
}
