import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/workflow_model.dart';
import 'package:khtn_ai_final_project/data/models/workflow_step_model.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';

class WorkflowsCart extends StatelessWidget {
  //final WorkflowModel workflow;
  final Workflow workflowType;
  const WorkflowsCart({super.key, required this.workflowType});

  @override
  Widget build(BuildContext context) {
    final workflow = WorkflowModel(workflow: workflowType);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: AppBorderRadius.medium,
          color: Colors.grey.shade50,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.fork_right, color: Theme.of(context).primaryColor, size: 24),
                    SizedBox(width: 8),
                    Text(
                      workflow.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                  ),
                  child: Text(workflow.feature),
                ),
              ],
            ),
            const SizedBox(height: 4),

            Text(
              workflow.description,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 12),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            const SizedBox(height: 12),

            // Workflow steps
            Text(
              '${workflow.steps.length} steps',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w100,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 8),
            ...workflow.steps.map((step) => WorkflowStep(step: step)),
          ],
        ),
      ),
    );
  }
}

class WorkflowStep extends StatelessWidget {
  final WorkflowStepModel step;

  const WorkflowStep({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              '${step.number}',
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12, height: 32,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.title, style: const TextStyle(fontSize: 14)),
                // Text(
                //   subtitle,
                //   style: const TextStyle(
                //     fontSize: 12,
                //     color: Colors.black54,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

