import 'assistant_model.dart';
import 'metadata_model.dart';

// Logic class
class ChatMessageModel {
  String content;
  List<String> files;
  AssistantModel assistant;
  String role;

  ChatMessageModel({
    required this.content, 
    required 
    this.files, 
    required this.assistant, 
    this.role = 'user'
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      content: json['content'],
      files: List<String>.from(json['files']),
      assistant: AssistantModel.fromJson(json['assistant']),
      role: json['role'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'files': files,
      'assistant': assistant.toJson(),
      'role': role,
    };
  }

  factory ChatMessageModel.createMessage(String content, String role, List<String> files) {
    return ChatMessageModel(
      content: content,
      files: files,
      assistant: AssistantModel.defaults(),
      role: role,
    );
  }
}

// Request Model for chat with bot
class ChatWithBotRequestModel {
  String content;
  List<String> files;
  AiChatMetadata metadata;
  AssistantModel assistant;

  ChatWithBotRequestModel({
    required this.content, 
    required this.files, 
    required this.assistant, 
    required this.metadata, 
  });

  factory ChatWithBotRequestModel.fromJson(Map<String, dynamic> json) {
    return ChatWithBotRequestModel(
      content: json['content'],
      files: List<String>.from(json['files']),
      metadata: AiChatMetadata.fromJson(json['metadata']),
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

// Request Model for send message
class SendMessageRequestModel {
  AssistantModel assistant;
  String content;
  List<String> files;
  AiChatMetadata metadata;
  

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
      metadata: AiChatMetadata.fromJson(json['metadata']),
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

