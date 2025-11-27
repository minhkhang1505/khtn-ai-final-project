import 'package:khtn_ai_final_project/data/models/chat_model.dart';
import 'package:khtn_ai_final_project/data/models/conversation_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/chat_repository.dart';

class ChatUsecase {
  final ChatRepository chatRepository;
  ChatUsecase({required this.chatRepository});

  Future<MessageRequestModel> sendMessage(MessageRequestModel messageRequest) async {
    return await chatRepository.sendMessage(messageRequest);
  }

  Future<MessageRequestModel> chatWithBot(MessageRequestModel messageRequest) async {
    return await chatRepository.chatWithBot(messageRequest);
  }

  Future<ConversationRequestModel> getConversations(ConversationRequestModel conversationRequest) async {
    return await chatRepository.getConversations(conversationRequest);
  }

  Future<ConversationRequestModel> getConversationHistory(ConversationRequestModel conversationRequest) async {
    return await chatRepository.getConversationHistory(conversationRequest);
  }
}
