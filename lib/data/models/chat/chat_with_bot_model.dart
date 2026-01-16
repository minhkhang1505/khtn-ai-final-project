import '../assistant_model.dart';
import '../metadata_model.dart';

// Request Model for chat with bot
class ChatWithBotRequestModel {
  String content;
  List<String> files;
  MetadataModel metadata;
  AssistantModel assistant;
  String? responseMode;

  ChatWithBotRequestModel({
    required this.content, 
    required this.files, 
    required this.assistant, 
    required this.metadata, 
    this.responseMode,
  });

  factory ChatWithBotRequestModel.fromJson(Map<String, dynamic> json) {
    return ChatWithBotRequestModel(
      content: json['content'],
      files: List<String>.from(json['files']),
      metadata: MetadataModel.fromJson(json['metadata']),
      assistant: AssistantModel.fromJson(json['assistant']),
      responseMode: json['responseMode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'files': files,
      'metadata': metadata.toJson(),
      'assistant': assistant.toJson(),
      if (responseMode != null) 'responseMode': responseMode,
    };
  }
}

// Response Model for chat with bot
class ChatWithBotResponseModel {
  String message;
  int remainingUsage;

  ChatWithBotResponseModel({required this.message, required this.remainingUsage});

  factory ChatWithBotResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    return ChatWithBotResponseModel(
      message: json['message'],
      remainingUsage: json['remainingUsage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'remainingUsage': remainingUsage};
  }
}