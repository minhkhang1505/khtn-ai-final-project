import 'package:khtn_ai_final_project/data/models/chat/chat_model.dart';
import '../assistant_model.dart';

class ConversationSendRequestModel {
  List<ChatMessageModel> messages = [];
  String id;

  ConversationSendRequestModel({required this.id, required this.messages});
  factory ConversationSendRequestModel.fromJson(Map<String, dynamic> json) {
    var messagesFromJson = json['messages'] as List;
    List<ChatMessageModel> messageList = messagesFromJson.map((msg) => ChatMessageModel(
      content: msg['content'],
      files: List<String>.from(msg['files']),
      assistant: AssistantModel.fromJson(msg['assistant']),
    )).toList();

    return ConversationSendRequestModel(
      id: json['id'],
      messages: messageList,
    );
  }

  factory ConversationSendRequestModel.defaults() {
    return ConversationSendRequestModel(
      id: '',
      messages: [],
    );
  }
}
