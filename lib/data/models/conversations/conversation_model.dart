import '../assistant_model.dart';

class ConversationModel {
  String title;
  String id;
  String createdAt;
  AssistantModel bot;

  ConversationModel({required this.id, required this.title, required this.createdAt, required this.bot});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      createdAt: json['createdAt'] ?? '',
      bot: (json['bot'] is Map<String, dynamic>)
          ? AssistantModel.fromJson(json['bot'])
          : AssistantModel.defaults(),
    );
  }

  factory ConversationModel.defaults() {
    return ConversationModel(
      id: '',
      title: '',
      createdAt: '',
      bot: AssistantModel.defaults(),
    );
  }
}