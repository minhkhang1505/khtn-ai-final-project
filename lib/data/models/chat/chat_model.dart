import '../assistant_model.dart';

class ChatMessageModel {
  String content;
  List<String>? files;
  AssistantModel assistant;
  String role;
  

  ChatMessageModel({
    required this.content, 
    required 
    this.files, 
    required this.assistant, 
    this.role = 'user',
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