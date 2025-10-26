import 'package:flutter/material.dart';
import 'workflows_cart.dart' show WorkflowsCart, Workflow;

class WorkflowsTab extends StatelessWidget {
  const WorkflowsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WorkflowsCart(workflow: Workflow.emailTriage),
            const SizedBox(height: 12),
            WorkflowsCart(workflow: Workflow.dataExtraction),
            const SizedBox(height: 12),
            WorkflowsCart(workflow: Workflow.dataExtraction),
          ],
        ),
      ),
    );
  }
}