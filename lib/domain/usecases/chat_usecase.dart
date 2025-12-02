import 'package:khtn_ai_final_project/data/models/chat_model.dart';
import 'package:khtn_ai_final_project/data/models/conversation_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/chat_repository.dart';

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
