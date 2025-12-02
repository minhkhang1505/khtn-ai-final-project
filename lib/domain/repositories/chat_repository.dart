import 'package:khtn_ai_final_project/data/models/chat_model.dart';
import 'package:khtn_ai_final_project/data/models/conversation_model.dart';

abstract class ChatRepository {
  Future<SendMessageResponseModel> sendMessage(SendMessageRequestModel messageRequest);
  Future<ChatWithBotResponseModel> chatWithBot(ChatWithBotRequestModel messageRequest);
  Future<GetConversationsResponseModel> getConversations(GetConversationsRequestModel conversationRequest);
  Future<GetConversationHistoryResponseModel> getConversationHistory(GetConversationHistoryRequestModel conversationRequest);
}
