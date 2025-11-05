import 'workflow_model.dart' show Workflow;

class AgentModel {
  final String name;
  final String description;
  final List<Workflow> workflows;
  final String state;

  const AgentModel({
    required this.name,
    required this.description,
    required this.workflows,
    required this.state,
  });

  // Additional methods to create a list of sample agents
  static List<AgentModel> createSampleAgents() {
    return [
      const AgentModel(
        name: 'Email Assistant',
        description: 'Handles email workflows automatically.',
        workflows: [Workflow.emailTriage],
        state: 'Active',
      ),
      const AgentModel(
        name: 'Data Extractor',
        description: 'Extracts data from documents.',
        workflows: [Workflow.dataExtraction],
        state: 'Inactive',
      ),
      const AgentModel(
        name: 'Customer Support Bot',
        description: 'Assists customers with common inquiries.',
        workflows: [Workflow.emailTriage, Workflow.dataExtraction],
        state: 'Active',
      ),
    ];
  }
}