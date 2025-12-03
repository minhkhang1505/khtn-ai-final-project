import 'conversations/conversation_send_request_model.dart';

class MetadataModel {
  final ConversationSendRequestModel conversation;

  MetadataModel({required this.conversation});
  
  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      conversation: ConversationSendRequestModel.fromJson(json['conversation']),
    );
  }

  factory MetadataModel.defaults() {
    return MetadataModel(
      conversation: ConversationSendRequestModel.defaults(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversation': {
        'messages': conversation.messages.map((msg) => {
          'content': msg.content,
          'files': msg.files,
          'assistant': msg.assistant.toJson(),
          'role': msg.role,
        }).toList(),
      },
    };
  }
}