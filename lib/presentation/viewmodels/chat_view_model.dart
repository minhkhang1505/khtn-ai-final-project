import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/usecases/chat_usecase.dart';

import 'package:khtn_ai_final_project/data/models/chat/chat_model.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/send_message.dart';
import 'package:khtn_ai_final_project/data/models/metadata_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversations_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_history_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/chat_with_bot_model.dart';

/// ViewModel responsible for chat page state.
class ChatViewModel extends ChangeNotifier {
  final ChatUseCase chatUsecase;

  ChatViewModel({
    required this.chatUsecase
  }) {
    // Fetch conversations on init
    getConversations();
  }

  // State variables
  final ScrollController scrollController = ScrollController();

  List<ChatMessageModel> messages = [];
  AssistantModel assistant = AssistantModel.defaults();
  MetadataModel metadata = MetadataModel.defaults();
  List<ConversationModel> conversations = [];
  List <String> fileIds = [];
  String? selectedModel = 'gpt-4o-mini';
  String conversationId = ''; // Default conversation ID
  String cursor = '';
  String? _error;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Send a message as the user, append the user's message and the reply.
  Future<bool> sendMessage(String content) async {
    final trimmed = content.trim();
    if (trimmed.isEmpty) return false;

    // Create a user message and append
    final userMsg = ChatMessageModel.createMessage(trimmed, 'user', []);
    messages.add(userMsg);
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollToBottom();
    });
    _isLoading = true;
    notifyListeners();

    try {
      final request = SendMessageRequestModel(
        content: trimmed,
        files: [],
        metadata: metadata,
        assistant: assistant,
      );
      final response = await chatUsecase.sendMessage(request);
      final replyMessage = ChatMessageModel.createMessage(response.message, 'assistant', []);
      addMessage(replyMessage);

      // Scroll to bottom after a slight delay to ensure UI has updated
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollToBottom();
      });

      return true;
    } catch (e) {
      // On error, add a simple assistant message describing failure
      debugPrint("Error sending message: $e");
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getConversations() async {
    try {
      final response = await chatUsecase.getConversations(
        GetConversationsRequestModel(
          cursor: '',
          limit: 20,
          assistantId: selectedModel?.isNotEmpty == true ? selectedModel : null,
          assistantModel: 'dify',
        ),
      );

      conversations = response.items;
    } catch (e) {
      debugPrint("Error fetching conversations: $e");
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return true;
  }

  Future<bool> getConversationHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await chatUsecase.getConversationHistory(
        GetConversationHistoryRequestModel(
          cursor: '',
          limit: 100,
          assistantId: selectedModel ?? '',
          assistantModel: 'dify',
          conversationId: conversationId,
        ),
      );

      // Append messages from history
      final messageList = response.items;
      for (var msg in messageList) {
        final chatMsg = ChatMessageModel.createMessage(
          msg.query,
          'user',
          [],
        );
        messages.add(chatMsg);

        final replyMsg = ChatMessageModel.createMessage(
          msg.answer,
          'assistant',
          [],
        );
        messages.add(replyMsg);
      }
    } catch (e) {
      debugPrint("Error fetching conversations: $e");
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return true;
  }

  Future<bool> chatWithBot(String content) async {
    
    final trimmed = content.trim();
    if (trimmed.isEmpty) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final request = ChatWithBotRequestModel(
        content: trimmed,
        files: [],
        metadata: metadata,
        assistant: assistant,
      );
      final response = await chatUsecase.chatWithBot(request);
      final replyMessage = ChatMessageModel.createMessage(response.message, 'assistant', []);
      addMessage(replyMessage);

      // Scroll to bottom after a slight delay to ensure UI has updated
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollToBottom();
      });

    } catch (e) {
      // On error, add a simple assistant message describing failure
      debugPrint("Error chatting with bot: $e");
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return true;
  }

  /// Add a pre-built message (useful for initializing from history)
  void addMessage(ChatMessageModel message) {
    messages.add(message);
    notifyListeners();
  }

  /// Clear conversation
  void clearMessages() {
    messages.clear();
    notifyListeners();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}