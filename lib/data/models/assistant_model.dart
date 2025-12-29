// ignore_for_file: constant_identifier_names

enum AssistantModelType {
  CLAUDE_3_HAIKU("claude-3-haiku-20240307"),
  GEMINI_15_FLASH("gemini-1.5-flash-latest"),
  GEMINI_15_PRO("gemini-1.5-pro-latest"),
  GPT_4_O("gpt-4o"),
  GPT_4O_MINI("gpt-4o-mini");
  final String id;

  const AssistantModelType(this.id); 

  static AssistantModelType getModelFromId(String id) {
    try {
      return AssistantModelType.values.firstWhere(
        (value) => value.id == id,
      );
    } on StateError {
      return AssistantModelType.GPT_4O_MINI;
    }
  }

  static String getModelId (AssistantModelType type) {
    return type.id;
  }

  static List<String> get allModelIds {
    return AssistantModelType.values.map((e) => e.id).toList();
  }

  // Get display name of the model from id
  static String nameFromId(String id) {
    try {
      return AssistantModelType.values
          .firstWhere((e) => e.id == id)
          .displayName;
    } catch (_) {
      return "Unknown Model";
    }
  }

  String get displayName {
    return switch (this) {
      AssistantModelType.CLAUDE_3_HAIKU => "Claude 3 Haiku",
      AssistantModelType.GEMINI_15_FLASH => "Gemini 1.5 Flash",
      AssistantModelType.GEMINI_15_PRO => "Gemini 1.5 Pro",
      AssistantModelType.GPT_4_O => "GPT-4o",
      AssistantModelType.GPT_4O_MINI => "GPT-4o Mini",
    };
  }
}

class AssistantModel {
  String model = "dify"; // default model
  String name;
  String id;

  AssistantModel({required this.model, this.name = 'GPT-4o Mini', this.id = 'gpt-4o-mini'});

  factory AssistantModel.fromJson(Map<String, dynamic> json) {
    return AssistantModel(
      model: json['model'],
      name: json['name'],
      id: json['id'],
    );
  }

  factory AssistantModel.fromMap(Map<String, dynamic> map) {
    return AssistantModel(
      model: map['model'],
      name: map['name'],
      id: map['id'],
    );
  }

  factory AssistantModel.defaults() {
    return AssistantModel(
      model: "dify",
      name: 'GPT 4o Mini',
      id: 'gpt-4o-mini',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'name': name,
      'id': id,
    };
  }
}