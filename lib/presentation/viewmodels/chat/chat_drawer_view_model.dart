import 'package:khtn_ai_final_project/data/models/conversations/conversation_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversations_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/delete_conversation_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/chat_usecase.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatDrawerViewModel extends ChangeNotifier {
  final ChatUseCase chatUsecase;

  ChatDrawerViewModel({
    required this.chatUsecase,
  }) {
    // Fetch conversations on initialization
    getConversations();
  }

  List<ConversationModel> conversations = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> getConversations() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await chatUsecase.getConversations(
        GetConversationsRequestModel(
          cursor: '',
          limit: 20,
          assistantId: 'gemini-4o-mini',
          assistantModel: 'dify',
        ),
      );

      conversations = response.items;
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return true;
  }

  void deleteConversation(String conversationId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await chatUsecase.deleteConversation(
        DeleteConversationRequestModel(
          conversationId: conversationId,
          assistantId: 'gemini-4o-mini',
          assistantModel: 'agentic',
        ),
      );

      // Remove from local list
      conversations.removeWhere((conv) => conv.id == conversationId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}