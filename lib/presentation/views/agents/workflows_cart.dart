import 'package:flutter/material.dart';

enum Workflow { emailTriage, dataExtraction }

class WorkflowsCart extends StatelessWidget {
  final Workflow workflow;
  final String workflowName;
  final String workflowDescription;
  final String feature;
  final List<WorkflowStep> steps;
  final String state;

  const WorkflowsCart._({
    required this.workflow,
    required this.workflowName,
    required this.workflowDescription,
    required this.feature,
    required this.steps,
    required this.state,
  });

  factory WorkflowsCart({required Workflow workflow}) {
    switch (workflow) {
      case Workflow.emailTriage:
        return WorkflowsCart._(
          workflow: workflow,
          workflowName: 'Email Triage',
          workflowDescription:
              'Automatically categorize and respond to emails',
          feature: 'New Email',
          state: 'Active',
          steps: const [
            WorkflowStep(number: 1, title: 'Read Email', subtitle: 'email.read'),
            WorkflowStep(number: 2, title: 'Categorize', subtitle: 'ai.classify'),
            WorkflowStep(number: 3, title: 'Send Response', subtitle: 'email.send'),
          ],
        );

      case Workflow.dataExtraction:
        return WorkflowsCart._(
          workflow: workflow,
          workflowName: 'Data Extraction',
          workflowDescription:
              'Extracts structured data from PDF, invoices, or forms automatically.',
          feature: 'Data Extraction',
          state: 'Inactive',
          steps: const [
            WorkflowStep(number: 1, title: 'Read Document', subtitle: 'file.read'),
            WorkflowStep(number: 2, title: 'Extract Data', subtitle: 'ai.extract'),
            WorkflowStep(number: 3, title: 'Save to DB', subtitle: 'data.save'),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
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
                      workflowName,
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
                  child: Text(feature),
                ),
              ],
            ),
            const SizedBox(height: 4),

            Text(
              workflowDescription,
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
              '${steps.length} steps',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w100,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 8),
            ...steps,
          ],
        ),
      ),
    );
  }
}

class WorkflowStep extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;

  const WorkflowStep({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
  });

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
              '$number',
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
                Text(title, style: const TextStyle(fontSize: 14)),
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

