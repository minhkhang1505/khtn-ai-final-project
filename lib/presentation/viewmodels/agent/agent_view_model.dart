import 'package:flutter/foundation.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'package:khtn_ai_final_project/data/models/workflow_model.dart' show Workflow;
import 'package:injectable/injectable.dart';

@injectable
class AgentViewModel extends ChangeNotifier {
  final List<AgentModel> _agents = [];

  List<AgentModel> get agents => _agents;

  void loadAgents() {
    _agents.addAll([
      AgentModel(
        id: '1',
        name: 'Email Assistant',
        description: 'Handles email workflows automatically.',
        workflows: [Workflow.emailTriage],
        status: 'Active',
      ),
      AgentModel(
        id: '2',
        name: 'Document Processor',
        description: 'Processes documents efficiently.',
        workflows: [Workflow.dataExtraction],
        status: 'Inactive',
      ),
    ]);
    notifyListeners();
  }
}
