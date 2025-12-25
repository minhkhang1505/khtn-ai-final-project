import 'package:khtn_ai_final_project/data/models/chat/chat_with_bot_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/send_message.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_history_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversations_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/delete_conversation_model.dart';

abstract class ChatRepository {
  Future<SendMessageResponseModel> sendMessage(SendMessageRequestModel messageRequest);
  Future<ChatWithBotResponseModel> chatWithBot(ChatWithBotRequestModel messageRequest);
  Future<GetConversationsResponseModel> getConversations(GetConversationsRequestModel conversationRequest);
  Future<GetConversationHistoryResponseModel> getConversationHistory(GetConversationHistoryRequestModel conversationRequest);
  Future<void> deleteConversation(DeleteConversationRequestModel deleteConversationRequestModel);
}
