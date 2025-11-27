import 'package:khtn_ai_final_project/data/models/chat_model.dart';
import 'package:khtn_ai_final_project/data/models/conversation_model.dart';

abstract class ChatRepository {
  Future<MessageRequestModel> sendMessage(MessageRequestModel messageRequest);
  Future<MessageRequestModel> chatWithBot(MessageRequestModel messageRequest);
  Future<ConversationRequestModel> getConversations(ConversationRequestModel conversationRequest);
  Future<ConversationRequestModel> getConversationHistory(ConversationRequestModel conversationRequest);
}
