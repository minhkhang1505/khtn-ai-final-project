import 'conversation_model.dart';

class AiChatMetadata {
  final ChatConversationModel conversation;

  AiChatMetadata({required this.conversation});
  
  factory AiChatMetadata.fromJson(Map<String, dynamic> json) {
    return AiChatMetadata(
      conversation: ChatConversationModel.fromJson(json['conversation']),
    );
  }
}