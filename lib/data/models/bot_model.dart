class BotModel {
  String name;
  String description;
  String category;
  String model;
  String status;
  String prompt;
  bool visibility;

  BotModel({
    required this.name,
    required this.description,
    required this.category,
    required this.status,
    required this.model,
    required this.prompt,
    required this.visibility,
  });
}