import 'workflow_step_model.dart';

enum Workflow { emailTriage, dataExtraction, planning}

extension WorkflowFeature on Workflow {
  String get feature {
    switch (this) {
      case Workflow.emailTriage:
        return 'New Email';
      case Workflow.dataExtraction:
        return 'Data Extraction';
      case Workflow.planning:
        return 'Task Planning';
    }
  }
}

extension WorkflowName on Workflow {
  String get name {
    switch (this) {
      case Workflow.emailTriage:
        return 'Email Triage';
      case Workflow.dataExtraction:
        return 'Data Extraction';
      case Workflow.planning:
        return 'Task Planning';
    }
  }
}

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
      case Workflow.planning:
        return WorkflowModel._(
          workflow: workflow,
          name: 'Task Planning',
          description:
              'Helps users plan and organize their tasks effectively.',
          feature: 'Task Planning',
          state: 'Active',
          steps: const [
            WorkflowStepModel(number: 1, title: 'Generate plan', subtitle: 'task.plan'),
            WorkflowStepModel(number: 2, title: 'Generate checklist', subtitle: 'task.checklist'),
            WorkflowStepModel(number: 3, title: 'Estimate time', subtitle: 'task.estimate'),
          ],
        );
    }
  }
}
