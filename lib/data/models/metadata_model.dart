import 'conversation_model.dart';

class AiChatMetadata {
  final ChatConversationModel conversation;

  AiChatMetadata({required this.conversation});
  
  factory AiChatMetadata.fromJson(Map<String, dynamic> json) {
    return AiChatMetadata(
      conversation: ChatConversationModel.fromJson(json['conversation']),
    );
  }

  factory AiChatMetadata.defaults() {
    return AiChatMetadata(
      conversation: ChatConversationModel.defaults(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversation': {
        //'id': conversation.id,
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