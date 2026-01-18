import 'workflow_model.dart' show Workflow;

class AgentModel {
  final String id;
  String name;
  String description;
  List<Workflow> workflows;
  String status;

  AgentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.workflows,
    required this.status,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AgentModel && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  // Additional methods to create a list of sample agents
  static List<AgentModel> createSampleAgents() {
    return [
      AgentModel(
        id: '1',
        name: 'Planning Bot',
        description: 'Assists customers to plan their tasks.',
        workflows: const [Workflow.planning],
        status: 'Active',
      ),
      AgentModel(
        id: '2',
        name: 'Email Assistant',
        description: 'Handles email workflows automatically.',
        workflows: const [Workflow.emailTriage],
        status: 'Inactive',
      ),
      AgentModel(
        id: '3',
        name: 'Data Extractor',
        description: 'Extracts data from documents.',
        workflows: const [Workflow.dataExtraction],
        status: 'Inactive',
      ),
      AgentModel(
        id: '4',
        name: 'Customer Support Bot',
        description: 'Assists customers with common inquiries.',
        workflows: const [Workflow.emailTriage, Workflow.dataExtraction],
        status: 'Inactive',
      ),
      
    ];
  }
}