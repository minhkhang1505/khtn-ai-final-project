// ignore_for_file: constant_identifier_names

enum AssistantModelType {
  CLAUDE_3_HAIKU("claude-3-haiku-20240307"),
  CLAUDE_3_SONNET("claude-3-sonnet-20240229"),
  GEMINI_15_FLASH("gemini-1.5-flash-latest"),
  GEMINI_15_PRO("gemini-1.5-pro-latest"),
  GPT_4_O("gpt-4o"),
  GPT_4O_MINI("gpt-4o-mini");
  final String id;

  const AssistantModelType(this.id); 

  static AssistantModelType? fromId(String id) {
    try {
      return AssistantModelType.values.firstWhere(
        (value) => value.id == id,
      );
    } on StateError {
      return null;
    }
  }
}

class AssistantModel {
  String model;
  String name;
  String id;

  AssistantModel({required this.model, this.name = 'Default Assistant', this.id = ''});

  factory AssistantModel.fromJson(Map<String, dynamic> json) {
    return AssistantModel(
      model: json['model'],
      name: json['name'] ?? 'Default Assistant',
      id: json['id'] ?? '',
    );
  }

  factory AssistantModel.sample() {
    return AssistantModel(
      model: AssistantModelType.GPT_4_O.id,
      name: 'Sample Assistant',
      id: 'assistant_sample_id',
    );
  }
}