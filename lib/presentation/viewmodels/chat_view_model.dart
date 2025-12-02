import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/chat_usecase.dart';
import 'package:khtn_ai_final_project/data/models/chat_model.dart';
import 'package:khtn_ai_final_project/data/models/metadata_model.dart';

/// ViewModel responsible for chat page state.
class ChatViewModel extends ChangeNotifier {
  final ChatUseCase chatUsecase;

  ChatViewModel({
    required this.chatUsecase
  });

  // State variables
  final ScrollController scrollController = ScrollController();

  List<ChatMessageModel> messages = [];
  AssistantModel assistant = AssistantModel.defaults();
  AiChatMetadata metadata = AiChatMetadata.defaults();
  List <String> fileIds = [];
  String selectedBot = 'default';
  String conversationId = '';
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
    // TODO: Implement fetching conversations
    return true;
  }

  Future<bool> getConversationHistory() async {
    // TODO: Implement fetching conversations
    return true;
  }

  Future<bool> chatWithBot() async {
    // TODO : Implement chatting with bot
    return true;
  }

  /// Add a pre-built message (useful for initializing from history)
  void addMessage(ChatMessageModel message) {
    messages.add(message);
    notifyListeners();
  }

  /// Clear conversation
  void clear() {
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