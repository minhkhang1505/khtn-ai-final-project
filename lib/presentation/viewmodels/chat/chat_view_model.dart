// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khtn_ai_final_project/data/models/token_usage_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/chat_usecase.dart';

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
    // Fetch conversations on init
    // getConversations();
    getUsage();
  }

  // State variables
  final ScrollController scrollController = ScrollController();
  final TextEditingController inputController = TextEditingController();

  List<ChatMessageModel> messages = [];
  AssistantModel assistant = AssistantModel.defaults();
  MetadataModel metadata = MetadataModel.defaults();
  //List<ConversationModel> conversations = [];
  List<PlatformFile> files = [];
  String assistantModel = 'gpt-4o-mini';
  String conversationId = ''; // Default conversation ID
  String conversationTitle = 'Chat';
  TokenUsageModel tokenUsage = TokenUsageModel.defaults();
  String cursor = '';
  String? _error;
  bool _isLoading = false;
  bool _isStreaming = false;

  // Setters
  set conversationIdSetter(String id) {
    conversationId = id;
    notifyListeners();
  }

  set conversationTitleSetter(String title) {
    conversationTitle = title;
    notifyListeners();
  }

  set assistantModelSetter(String model) {
    assistantModel = model;
    notifyListeners();
  }

  set assistantSetter(AssistantModel assistantModel) {
    assistant = assistantModel;
  }

  set metadataSetter(MetadataModel metadataModel) {
    metadata = metadataModel;
    notifyListeners();
  }

  set filesSetter(List<PlatformFile> fileList) {
    files = fileList;
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

  // set isStreamingSetter(bool streaming) {
  //   _isStreaming = streaming;
  //   notifyListeners();
  // }

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

  String get messagesContent {
    String temp = metadata.conversation.messages
        .map((msg) => "${msg.role}: ${msg.content}")
        .join('\n');
    temp += "\n\nTotal messages: ${metadata.conversation.messages.length}";
    temp += "\nConversation ID: ${metadata.conversation.id}";

    temp = metadata.toJson().toString();

    return temp;
  }

  void setInputMessage(String content) {
    inputController.text = content;
    notifyListeners();
  }

  void openChat(String conversationId) {
    conversationIdSetter = conversationId;
    getConversationHistory();
  }

  /// Send a message as the user, append the user's message and the reply.
  Future<bool> sendMessage(String content) async {
    final trimmed = content.trim();

    if (files.isNotEmpty) {
      errorSetter = "File upload not implemented yet.";
      return false;
    }

    // Validate message
    final validationError = validateInputMessage(trimmed);
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
      final request = SendMessageRequestModel(
        content: trimmed,
        files: [],
        metadata: metadata,
        assistant: assistant,
      );
      final response = await chatUsecase.sendMessage(request);

      // Update remaining tokens
      tokenUsage.availableTokens = response.remainingUsage;

      // For streaming responses, simulate by appending chunks;
      await addStreamingAssistantMessage(response.message);

      conversationIdSetter = response.conversationId;

      // Update metadata after message exchange
      updateMetadata();

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
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getConversationHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await chatUsecase.getConversationHistory(
        GetConversationHistoryRequestModel(
          cursor: '',
          limit: 100,
          assistantId: assistantModel,
          assistantModel: 'dify',
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
      updateMetadata();

      // Auto-scroll to last message after loading conversation
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollToBottom();
      });
    } catch (e) {
      errorSetter = e.toString();
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
    } catch (e) {
      // On error, add a simple assistant message describing failure
      errorSetter = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return true;
  }

  String validateInputMessage(String content) {
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
    conversationTitleSetter = 'Chat';
    metadataSetter = MetadataModel.defaults();
    errorSetter = null;
    notifyListeners();
  }

  /// Add a pre-built message (useful for initializing from history)
  void addMessage(ChatMessageModel message) {
    messages.add(message);
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

  /// Simulate adding an assistant message in a streaming fashion
  Future<void> addStreamingAssistantMessage(String fullText) async {
    final msg = ChatMessageModel.createMessage(fullText, 'assistant', []);
    _isLoading = false;
    _isStreaming = true;

    messages.add(msg);
    notifyListeners();
    scrollToBottom();

    // Stream multiple characters at once for faster display
    const chunkSize = 3; // Display 3 characters at a time
    const delayMs = 30; // Delay between chunks (much faster)

    for (int i = 0; i < fullText.length; i += chunkSize) {
      await Future.delayed(const Duration(milliseconds: delayMs));
      final end = (i + chunkSize).clamp(0, fullText.length);
      msg.content = fullText.substring(0, end);
      notifyListeners();

      // Only scroll every few chunks to reduce overhead
      if (i % (chunkSize * 3) == 0 || end == fullText.length) {
        scrollToBottom();
      }
    }

    _isStreaming = false;
    notifyListeners();
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

  /// Add files to the current draft/files list
  void addFiles(List<PlatformFile> newFiles) {
    files.addAll(newFiles);
    notifyListeners();
    // Ensure UI scrolls to bottom to reveal any new file UI
    // Use delayed callback to allow UI to rebuild first
    Future.delayed(const Duration(milliseconds: 150), () {
      scrollToBottom();
    });
  }

  /// Remove file at index
  void removeFileAt(int index) {
    if (index >= 0 && index < files.length) {
      files.removeAt(index);
      notifyListeners();
      // Use delayed callback to allow UI to rebuild first
      Future.delayed(const Duration(milliseconds: 150), () {
        scrollToBottom();
      });
    }
  }

  /// Clear all selected files
  void clearFiles() {
    filesSetter = [];
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

  @override
  void dispose() {
    scrollController.dispose();
    inputController.dispose();
    super.dispose();
  }
}
