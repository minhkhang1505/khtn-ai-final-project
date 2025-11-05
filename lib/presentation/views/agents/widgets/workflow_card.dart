import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/workflow_model.dart';
import 'package:khtn_ai_final_project/data/models/workflow_step_model.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';

class WorkflowsCard extends StatelessWidget {
  //final WorkflowModel workflow;
  final Workflow workflowType;
  const WorkflowsCard({super.key, required this.workflowType});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final workflow = WorkflowModel(workflow: workflowType);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outline.withAlpha(50),
          width: 1.5,
        ),
        borderRadius: AppBorderRadius.extraLarge,
        color: colorScheme.surfaceContainerLow,
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
                  Icon(
                    Icons.fork_right,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    workflow.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              if (ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTablet(context))
                Chip(
                  label: Text(
                    workflow.feature,
                    style: TextStyle(color: colorScheme.primary),
                  ),
                  backgroundColor: colorScheme.surfaceContainerHigh,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
            ],
          ),
          const SizedBox(height: 4),

          Text(workflow.description, style: TextStyle(fontSize: 15)),
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
    );
  }
}

class WorkflowStep extends StatelessWidget {
  final WorkflowStepModel step;

  const WorkflowStep({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: colorScheme.tertiaryContainer.withAlpha(50),
            child: Text(
              '${step.number}',
              style: TextStyle(
                color: colorScheme.tertiary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12, height: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.title, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
