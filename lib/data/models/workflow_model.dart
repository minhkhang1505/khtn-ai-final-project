import 'workflow_step_model.dart';

enum Workflow { emailTriage, dataExtraction }

class WorkflowModel {
  final Workflow workflow;
  final String name;
  final String description;
  final String feature;
  final List<WorkflowStepModel> steps;
  final String state;

  const WorkflowModel._({
    required this.workflow,
    required this.name,
    required this.description,
    required this.feature,
    required this.steps,
    required this.state,
  });

  factory WorkflowModel({required Workflow workflow}) {
    switch (workflow) {
      case Workflow.emailTriage:
        return WorkflowModel._(
          workflow: workflow,
          name: 'Email Triage',
          description:
              'Automatically categorize and respond to emails',
          feature: 'New Email',
          state: 'Active',
          steps: const [
            WorkflowStepModel(number: 1, title: 'Read Email', subtitle: 'email.read'),
            WorkflowStepModel(number: 2, title: 'Categorize', subtitle: 'ai.classify'),
            WorkflowStepModel(number: 3, title: 'Send Response', subtitle: 'email.send'),
          ],
        );

      case Workflow.dataExtraction:
        return WorkflowModel._(
          workflow: workflow,
          name: 'Data Extraction',
          description:
              'Extracts structured data from PDF, invoices, or forms automatically.',
          feature: 'Data Extraction',
          state: 'Inactive',
          steps: const [
            WorkflowStepModel(number: 1, title: 'Read Document', subtitle: 'file.read'),
            WorkflowStepModel(number: 2, title: 'Extract Data', subtitle: 'ai.extract'),
            WorkflowStepModel(number: 3, title: 'Save to DB', subtitle: 'data.save'),
          ],
        );
    }
  }
}
