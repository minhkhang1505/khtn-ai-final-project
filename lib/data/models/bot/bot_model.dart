import '../assistant_model.dart';

class BotModel {
  final String id;
  final String assistantName;
  final String description;
  final String instructions;
  final AssistantModelType? model;
  final Map<String, dynamic>? config;
  final String? userId;
  final bool isDefault;
  final bool isFavorite;
  final String? openAiAssistantId;
  final String? openAiThreadIdPlay;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedAt;

  BotModel({
    required this.id,
    required this.assistantName,
    required this.description,
    required this.instructions,
    required this.model,
    required this.config,
    required this.userId,
    required this.isDefault,
    required this.isFavorite,
    required this.openAiAssistantId,
    required this.openAiThreadIdPlay,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
  });

  factory BotModel.fromJson(Map<String, dynamic> json) {
    final dynamic modelValue = json['model'] is Map<String, dynamic>
        ? (json['model'] as Map<String, dynamic>)['id']
        : json['model'];

    return BotModel(
      id: json['id']?.toString() ?? '',
      assistantName:
          json['assistant_name'] ?? json['assistantName'] ?? json['name'] ?? '',
      description: json['description'] ?? '',
      instructions: json['instructions'] ?? '',
      model: modelValue is String ? AssistantModelType.fromId(modelValue) : null,
      config: json['config'] as Map<String, dynamic>?,
      userId: (json['user_id'] ?? json['userId'])?.toString(),
      isDefault: _asBool(json['is_default'] ?? json['isDefault']),
      isFavorite: _asBool(json['is_favorite'] ?? json['isFavorite']),
      openAiAssistantId:
          (json['open_ai_assistant_id'] ?? json['openAiAssistantId'])
              ?.toString(),
      openAiThreadIdPlay:
          (json['open_ai_thread_id_play'] ?? json['openAiThreadIdPlay'])
              ?.toString(),
      createdAt: json['created_at'] ?? json['createdAt']?.toString(),
      updatedAt: json['updated_at'] ?? json['updatedAt']?.toString(),
      createdBy: json['created_by'] ?? json['createdBy']?.toString(),
      updatedBy: json['updated_by'] ?? json['updatedBy']?.toString(),
      deletedAt: json['deleted_at'] ?? json['deletedAt']?.toString(),
    );
  }

  static bool _asBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assistant_name': assistantName,
      'description': description,
      'instructions': instructions,
      'model': model?.id,
      'config': config,
      'user_id': userId,
      'is_default': isDefault,
      'is_favorite': isFavorite,
      'open_ai_assistant_id': openAiAssistantId,
      'open_ai_thread_id_play': openAiThreadIdPlay,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt,
    };
  }
}