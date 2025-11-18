import 'assistant_model.dart';
import 'metadata_model.dart';
import 'conversation_model.dart';

// Logic class
class ChatMessageModel {
  final String content;
  List<String> files;
  AssistantModel assistant;
  String role;

  ChatMessageModel({
    required this.content, 
    required 
    this.files, 
    required this.assistant, 
    required AiChatMetadata metadata, 
    this.role = 'user'
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      content: json['content'],
      files: List<String>.from(json['files']),
      assistant: AssistantModel.fromJson(json['assistant']),
      metadata: AiChatMetadata.fromJson(json['metadata']),
      role: json['role'] ?? 'user',
    );
  }

  factory ChatMessageModel.sample() {
    return ChatMessageModel(
      content: "This is a sample message",
      files: [],
      assistant: AssistantModel.sample(),
      metadata: AiChatMetadata(conversation: ChatConversationModel.sample()),
      role: 'assistant',
    );
  }

  factory ChatMessageModel.sampleWithData(String content, String role) {
    return ChatMessageModel(
      content: content,
      files: [],
      assistant: AssistantModel.sample(),
      metadata: AiChatMetadata(conversation: ChatConversationModel.sample()),
      role: role,
    );
  }
}

// Request Model
class MessageRequestModel {
  String content;
  List<String> files;
  AssistantModel assistant;
  AiChatMetadata metadata;
  String role;

  MessageRequestModel({
    required this.content, 
    required this.files, 
    required this.assistant, 
    required this.metadata, 
    this.role = 'user'
  });

  factory MessageRequestModel.fromJson(Map<String, dynamic> json) {
    return MessageRequestModel(
      content: json['content'],
      files: List<String>.from(json['files']),
      assistant: AssistantModel.fromJson(json['assistant']),
      metadata: AiChatMetadata.fromJson(json['metadata']),
    );
  }
}

// Response Model
class MessageResponseModel {
  String conversationId;
  String message;
  int remainingUsage;

  MessageResponseModel({required this.conversationId, required this.message, required this.remainingUsage});

  Map<String, dynamic> toJson() {
    return {'conversationId': conversationId, 'message': message, 'remainingUsage': remainingUsage};
  }
}

