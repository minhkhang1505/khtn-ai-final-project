import 'message_model.dart';
import 'assistant_model.dart';
import 'metadata_model.dart';

class ChatConversationModel {
  List<ChatMessageModel> messages = [];
  String id;

  ChatConversationModel({required this.id, required this.messages});

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) {
    var messagesFromJson = json['messages'] as List;
    List<ChatMessageModel> messageList = messagesFromJson.map((msg) => ChatMessageModel(
      content: msg['content'],
      files: List<String>.from(msg['files']),
      assistant: AssistantModel.fromJson(msg['assistant']),
      metadata: AiChatMetadata.fromJson(msg['metadata']),
    )).toList();

    return ChatConversationModel(
      id: json['id'],
      messages: messageList,
    );
  }

  factory ChatConversationModel.sample() {
    return ChatConversationModel(
      id: 'sample_conversation_id',
      messages: [ChatMessageModel.sample()],
    );
  }
}