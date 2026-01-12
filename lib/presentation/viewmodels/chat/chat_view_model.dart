// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_model.dart';
import 'package:khtn_ai_final_project/data/models/token_usage_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/chat/chat_usecase.dart';

import 'package:khtn_ai_final_project/data/models/chat/chat_model.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/send_message.dart';
import 'package:khtn_ai_final_project/data/models/metadata_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_send_request_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_history_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/chat_with_bot_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/auth/get_user_usecase.dart';

import 'package:injectable/injectable.dart';

@injectable
class ChatViewModel extends ChangeNotifier {
  final ChatUseCase chatUsecase;
  final GetUserUseCase getUserUseCase;

  ChatViewModel({required this.chatUsecase, required this.getUserUseCase}) {
    getUsage();
  }

  // State variables
  final ScrollController scrollController = ScrollController();

  List<ChatMessageModel> messages = [];
  // AssistantModel assistant = AssistantModel.defaults();
  MetadataModel metadata = MetadataModel.defaults();
  String conversationId = ''; // Default conversation ID
  TokenUsageModel tokenUsage = TokenUsageModel.defaults();
  String cursor = '';
  String? _error;
  bool _isLoading = false;
  bool _isStreaming = false;
  String _inputMessage = '';

  // Setters
  set conversationIdSetter(String id) {
    conversationId = id;
    notifyListeners();
  }

  set metadataSetter(MetadataModel metadataModel) {
    metadata = metadataModel;
    notifyListeners();
  }

  set errorSetter(String? message) {
    _error = message;
    scrollToBottom();
    notifyListeners();
  }

  set isLoadingSetter(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  set tokenUsageSetter(TokenUsageModel usage) {
    tokenUsage = usage;
    notifyListeners();
  }

  // Getters
  int get availableTokens => tokenUsage.availableTokens;

  bool get isStreaming => _isStreaming;
  bool get isBusy => _isLoading || _isStreaming;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get inputMessage => _inputMessage;

  void openChat(ConversationModel conversation) {
    conversationIdSetter = conversation.id;
    clearError();
    clearMessages();
    updateMetadata();
    getConversationHistory(conversation.bot.id, conversation.bot.model);
  }

  /// Send a message as the user, append the user's message and the reply.
  Future<bool> sendMessage(String content, AssistantModel assistant, List<PlatformFile> files) async {
    final trimmed = content.trim();
    // Validate message
    final validationError = validateInputMessage(trimmed, files);
    if (validationError.isNotEmpty) {
      errorSetter = validationError;
      return false;
    }

    if (conversationId.isEmpty) {
      // New conversation - reset metadata
      conversationId = 'temp_id';
    }

    // Create a user message and append
    final userMsg = ChatMessageModel.createMessage(trimmed, 'user', []);
    messages.add(userMsg);
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollToBottom();
    });
    _isStreaming = true;
    _isLoading = false;
    
    // Create empty assistant message for streaming
    final assistantMsg = ChatMessageModel.createMessage('', 'assistant', []);
    messages.add(assistantMsg);
    notifyListeners();
    scrollToBottom();

    try {
      final request = SendMessageRequestModel(
        content: trimmed,
        files: [],
        metadata: metadata,
        assistant: assistant,
        responseMode: 'streaming',
      );
      
      String fullMessage = '';
      await for (var chunk in chatUsecase.sendMessageStream(request)) {
        fullMessage += chunk;
        assistantMsg.content = fullMessage;
        notifyListeners();
        scrollToBottom();
      }
      
      // Update conversation ID after streaming completes
      // Note: You may need to parse the final chunk or make a separate call to get conversation ID
      if (conversationId == 'temp_id') {
        // conversationIdSetter = parsed conversation ID from response
      }

      // Scroll to bottom after a slight delay to ensure UI has updated
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollToBottom();
      });

      return true;
    } catch (e) {
      // On error, add a simple assistant message describing failure
      errorSetter = e.toString();
      return false;
    } finally {
      _isStreaming = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getConversationHistory(String assistantId, String assistantModel) async {
    isLoadingSetter = true;
    try {
      final response = await chatUsecase.getConversationHistory(
        GetConversationHistoryRequestModel(
          assistantId: assistantId,
          assistantModel: assistantModel,
          conversationId: conversationId,
        ),
      );

      // Append messages from history
      final messageList = response.items;
      for (var msg in messageList) {
        final chatMsg = ChatMessageModel.createMessage(msg.query, 'user', []);
        messages.add(chatMsg);

        final replyMsg = ChatMessageModel.createMessage(
          msg.answer,
          'assistant',
          [],
        );
        messages.add(replyMsg);
      }

      // Auto-scroll to last message after loading conversation
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollToBottom();
      });
    } catch (e) {
      errorSetter = e.toString();
      return false;
    } finally {
      isLoadingSetter = false;
    }
    return true;
  }

  Future<bool> chatWithBot(String content, AssistantModel assistant, List<PlatformFile> files) async {
    final trimmed = content.trim();
    // Validate message
    final validationError = validateInputMessage(trimmed, files);
    if (validationError.isNotEmpty) {
      errorSetter = validationError;
      return false;
    }

    if (conversationId.isEmpty) {
      // New conversation - reset metadata
      conversationId = 'temp_id';
    }

    // Create a user message and append
    final userMsg = ChatMessageModel.createMessage(trimmed, 'user', []);
    messages.add(userMsg);
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollToBottom();
    });
    isLoadingSetter = true;

    try {
      final request = ChatWithBotRequestModel(
        content: trimmed,
        files: [],
        metadata: metadata,
        assistant: assistant,
        responseMode: 'streaming',
      );
      final response = await chatUsecase.chatWithBot(request);

      // Update remaining tokens
      tokenUsage.availableTokens = response.remainingUsage;

      final replyMessage = ChatMessageModel.createMessage(
        response.message,
        'assistant',
        [],
      );
      addMessage(replyMessage);

      // Scroll to bottom after a slight delay to ensure UI has updated
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollToBottom();
      });
      return true;
    } catch (e) {
      // On error, add a simple assistant message describing failure
      errorSetter = e.toString();
      return false;
    } finally {
      isLoadingSetter = false;
    }
  }

  String validateInputMessage(String content, List<PlatformFile> files) {

    if (files.isNotEmpty) {
      return "File upload not implemented yet.";
    }

    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      return "Message cannot be empty.";
    }
    if (trimmed.length > 5000) {
      return "Message exceeds maximum length of 5000 characters.";
    }
    if (tokenUsage.availableTokens <= 0) {
      return "Insufficient tokens to send message.";
    }
    return '';
  }

  /// New chat - clear messages and reset metadata
  void newChat() {
    messages.clear();
    conversationIdSetter = '';
    metadataSetter = MetadataModel.defaults();
    errorSetter = null;
    notifyListeners();
  }

  /// Add a pre-built message (useful for initializing from history)
  void addMessage(ChatMessageModel message) {
    messages.add(message);
    updateMetadata();
    notifyListeners();
  }

  /// Update metadata based on current conversation ID and messages
  void updateMetadata() {
    metadataSetter = MetadataModel(
      conversation: ConversationSendRequestModel(
        id: conversationId,
        messages: messages,
      ),
    );
  }

  /// Scroll message list to bottom
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void getUsage() async {
    try {
      final response = await getUserUseCase.getTokenUsage();
      tokenUsageSetter = response;
      return;
    } catch (e) {
      errorSetter = e.toString();
      rethrow;
    }
  }

  /// Clear conversation
  void clearMessages() {
    messages.clear();
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    errorSetter = null;
  }

  /// Set input message (for prompt injection)
  void setInputMessage(String message) {
    _inputMessage = message;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
