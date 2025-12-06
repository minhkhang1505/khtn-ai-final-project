import 'package:khtn_ai_final_project/domain/repositories/chat_repository.dart';
import 'package:khtn_ai_final_project/data/models/chat/chat_with_bot_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/send_message.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_history_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversations_model.dart';

class ChatUseCase {
  final ChatRepository chatRepository;
  ChatUseCase({required this.chatRepository});

  Future<SendMessageResponseModel> sendMessage(SendMessageRequestModel messageRequest) async {
    return await chatRepository.sendMessage(messageRequest);
  }

  Future<ChatWithBotResponseModel> chatWithBot(ChatWithBotRequestModel messageRequest) async {
    return await chatRepository.chatWithBot(messageRequest);
  }

  Future<GetConversationsResponseModel> getConversations(GetConversationsRequestModel conversationRequest) async {
    return await chatRepository.getConversations(conversationRequest);
  }

  Future<GetConversationHistoryResponseModel> getConversationHistory(GetConversationHistoryRequestModel conversationRequest) async {
    return await chatRepository.getConversationHistory(conversationRequest);
  }
}
