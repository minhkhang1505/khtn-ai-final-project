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

  // Get display name of the model from id
  static String nameFromId(String id) {
    try {
      return AssistantModelType.values
          .firstWhere((e) => e.id == id)
          .name;
    } catch (_) {
      return "Unknown Model";
    }
  }

  String get name {
    return switch (this) {
      AssistantModelType.CLAUDE_3_HAIKU => "Claude 3 Haiku",
      AssistantModelType.CLAUDE_3_SONNET => "Claude 3 Sonnet",
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

  AssistantModel({required this.model, this.name = 'Default Assistant', this.id = ''});

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
      name: 'GPT_4O_MINI',
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