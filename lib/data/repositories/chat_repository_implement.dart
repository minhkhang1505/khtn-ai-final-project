import 'package:khtn_ai_final_project/data/models/chat_model.dart';
import 'package:khtn_ai_final_project/data/models/conversation_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/chat_repository.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<SendMessageResponseModel> sendMessage(SendMessageRequestModel sendMessageRequest) async {
    final response = await remoteDataSource.sendMessage(sendMessageRequest);
    return response;
  }

  @override
  Future<ChatWithBotResponseModel> chatWithBot(ChatWithBotRequestModel chatWithBotRequest) async {
    final response = await remoteDataSource.chatWithBot(chatWithBotRequest);
    return response;
  }

  @override
  Future<GetConversationsResponseModel> getConversations(GetConversationsRequestModel getConversationsRequest) async {
    final response = await remoteDataSource.getConversations(getConversationsRequest);
    return response;
  }

  @override
  Future<GetConversationHistoryResponseModel> getConversationHistory(GetConversationHistoryRequestModel getConversationHistoryRequest) async {
    final response = await remoteDataSource.getConversationHistory(getConversationHistoryRequest);
    return response;
  }
}
