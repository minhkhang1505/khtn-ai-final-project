import '../assistant_model.dart';

class ChatMessageModel {
  String content;
  List<String>? files;
  List<String>? fileNames;
  AssistantModel assistant;
  String role;
  

  ChatMessageModel({
    required this.content, 
    required this.files, 
    this.fileNames,
    required this.assistant, 
    this.role = 'user',
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      content: json['content'],
      files: json['files'] != null
          ? List<String>.from(json['files'])
          : <String>[],
      fileNames: json['file_names'] != null
          ? List<String>.from(json['file_names'])
          : null,
      assistant: AssistantModel.fromJson(json['assistant']),
      role: json['role'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'files': files,
      'file_names': fileNames,
      'assistant': assistant.toJson(),
      'role': role,
    };
  }

  factory ChatMessageModel.createMessage(
    String content,
    String role,
    List<String> files, {
    List<String>? fileNames,
  }) {
    return ChatMessageModel(
      content: content,
      files: files,
      fileNames: fileNames,
      assistant: AssistantModel.defaults(),
      role: role,
    );
  }
}