import 'workflow_model.dart' show Workflow;

class AgentModel {
  final String name;
  final String description;
  final Workflow workflows;
  final String state;

  const AgentModel({
    required this.name,
    required this.description,
    required this.workflows,
    required this.state,
  });
}