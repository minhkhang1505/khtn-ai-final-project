import 'workflow_model.dart' show Workflow;

class AgentModel {
  String name;
  String description;
  List<Workflow> workflows;
  String status;

  AgentModel({
    required this.name,
    required this.description,
    required this.workflows,
    required this.status,
  });

  // Additional methods to create a list of sample agents
  static List<AgentModel> createSampleAgents() {
    return [
      AgentModel(
        name: 'Email Assistant',
        description: 'Handles email workflows automatically.',
        workflows: const [Workflow.emailTriage],
        status: 'Active',
      ),
      AgentModel(
        name: 'Data Extractor',
        description: 'Extracts data from documents.',
        workflows: const [Workflow.dataExtraction],
        status: 'Inactive',
      ),
      AgentModel(
        name: 'Customer Support Bot',
        description: 'Assists customers with common inquiries.',
        workflows: const [Workflow.emailTriage, Workflow.dataExtraction],
        status: 'Active',
      ),
    ];
  }
}