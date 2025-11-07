import 'agent_model.dart';

class BotModel {
  String id;
  String name;
  String description;
  String category;
  String model;
  String status;
  String prompt;
  bool visibility;
  List<AgentModel> subagents = [];

  BotModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.status,
    required this.model,
    required this.prompt,
    required this.visibility,
    required this.subagents,
  });
}