import 'package:khtn_ai_final_project/core/network/jarvis_api_client.dart';
import 'package:khtn_ai_final_project/data/models/chat/chat_with_bot_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/send_message.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversations_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_history_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/delete_conversation_model.dart';
import 'package:injectable/injectable.dart';

abstract class ChatRemoteDataSource {
  Future<SendMessageResponseModel> sendMessage(
    SendMessageRequestModel sendMessageRequest,
  );
  Future<ChatWithBotResponseModel> chatWithBot(
    ChatWithBotRequestModel chatWithBotRequest,
  );
  Future<GetConversationsResponseModel> getConversations(
    GetConversationsRequestModel getConversationsRequest,
  );
  Future<GetConversationHistoryResponseModel> getConversationHistory(
    GetConversationHistoryRequestModel getConversationHistoryRequest,
  );
  Future<DeleteConversationResponseModel> deleteConversation(
    DeleteConversationRequestModel deleteConversationModel,
  );
}

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final JarvisApiClient client;

  ChatRemoteDataSourceImpl(this.client);

  //for send message
  @override
  Future<SendMessageResponseModel> sendMessage(
    SendMessageRequestModel sendMessageRequest,
  ) async {
    final response = await client.post(
      '/ai-chat/messages',
      data: sendMessageRequest.toJson(),
    );
    return SendMessageResponseModel.fromJson(
      response.data,
      response.statusCode ?? 0,
    );
  }

  //for chat with bot
  @override
  Future<ChatWithBotResponseModel> chatWithBot(
    ChatWithBotRequestModel chatWithBotRequest,
  ) async {
    final response = await client.post(
      '/ai-chat/messages',
      data: chatWithBotRequest.toJson(),
    );
    return ChatWithBotResponseModel.fromJson(
      response.data,
      response.statusCode ?? 0,
    );
  }

  // for get conversations
  @override
  Future<GetConversationsResponseModel> getConversations(
    GetConversationsRequestModel getConversationsRequest,
  ) async {
    final response = await client.getWithQuery(
      '/ai-chat/conversations',
      queryParameters: getConversationsRequest.toJson(),
    );
    return GetConversationsResponseModel.fromJson(
      response.data,
      response.statusCode ?? 0,
    );
  }

  // for get conversation history
  @override
  Future<GetConversationHistoryResponseModel> getConversationHistory(
    GetConversationHistoryRequestModel getConversationHistoryRequest,
  ) async {
    final response = await client.getWithQuery(
      '/ai-chat/conversations/${getConversationHistoryRequest.conversationId}/messages',
      queryParameters: getConversationHistoryRequest.toJson(),
    );
    return GetConversationHistoryResponseModel.fromJson(
      response.data,
      response.statusCode ?? 0,
    );
  }

  // for delete conversation
  @override
  Future<DeleteConversationResponseModel> deleteConversation(
    DeleteConversationRequestModel deleteConversationRequestModel,
  ) async {
    final response = await client.deleteWithQuery(
      '/ai-chat/conversations/${deleteConversationRequestModel.conversationId}',
      queryParameters: deleteConversationRequestModel.toJson(),
    );
    return DeleteConversationResponseModel.fromJson(response.data);
  }
}
