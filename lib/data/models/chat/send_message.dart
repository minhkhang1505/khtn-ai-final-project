import '../assistant_model.dart';
import '../metadata_model.dart';

// Request Model for send message
class SendMessageRequestModel {
  AssistantModel assistant;
  String content;
  List<String> files;
  MetadataModel metadata;
  
  SendMessageRequestModel({
    required this.content, 
    required this.files, 
    required this.assistant, 
    required this.metadata, 
  });

  factory SendMessageRequestModel.fromJson(Map<String, dynamic> json) {
    return SendMessageRequestModel(
      content: json['content'],
      files: List<String>.from(json['files']),
      metadata: MetadataModel.fromJson(json['metadata']),
      assistant: AssistantModel.fromJson(json['assistant']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'files': files,
      'metadata': metadata.toJson(),
      'assistant': assistant.toJson(),
    };
  }
}

// Response Model for send message
class SendMessageResponseModel {
  String conversationId;
  String message;
  int remainingUsage;

  SendMessageResponseModel({required this.conversationId, required this.message, required this.remainingUsage});

  factory SendMessageResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    return SendMessageResponseModel(
      conversationId: json['conversationId'],
      message: json['message'],
      remainingUsage: json['remainingUsage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'conversationId': conversationId, 'message': message, 'remainingUsage': remainingUsage};
  }
}