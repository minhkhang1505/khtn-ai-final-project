// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_model.dart';
import 'package:khtn_ai_final_project/data/models/token_usage_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/chat/chat_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/datasource/upload_multiple_file_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/auth/get_user_usecase.dart';


import 'package:khtn_ai_final_project/data/models/chat/chat_model.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/send_message.dart';
import 'package:khtn_ai_final_project/data/models/metadata_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_send_request_model.dart';
import 'package:khtn_ai_final_project/data/models/conversations/conversation_history_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/chat_with_bot_model.dart';
import 'package:khtn_ai_final_project/data/models/datasource/multi_file_response.dart';

import 'package:injectable/injectable.dart';

@injectable
class ChatViewModel extends ChangeNotifier {
  final ChatUseCase chatUsecase;
  final GetUserUseCase getUserUseCase;
  final UploadMultipleFileUsecase uploadMultipleFileUsecase;

  ChatViewModel({required this.chatUsecase, required this.getUserUseCase, required this.uploadMultipleFileUsecase}) {
    getUsage();
  }

  // State variables
  final ScrollController scrollController = ScrollController();

  List<ChatMessageModel> messages = [];
  // AssistantModel assistant = AssistantModel.defaults();
  MetadataModel metadata = MetadataModel.defaults();
  String conversationId = ''; // Default conversation ID
  List<PlatformFile> attachedFiles = [];
  TokenUsageModel tokenUsage = TokenUsageModel.defaults();
  String cursor = '';
  String? _error;
  bool _isLoading = false;
  bool _isStreaming = false;
  String _inputMessage = '';

  void _safeNotifyListeners() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
      return;
    }
    notifyListeners();
  }

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

  Future<UploadResponse> uploadFiles(List<PlatformFile> files) async {
    try {
      final result = await uploadMultipleFileUsecase.call(files);

      if (result.files.isEmpty) {
        throw Exception('No files were uploaded');
      }

      return result;
    } catch (e) {
      debugPrint("Error in uploadFiles: $e");
      rethrow; // Re-throw to let caller handle the error
    }
  }

  /// Send a message as the user, append the user's message and the reply.
  Future<bool> sendMessage(
    String content,
    AssistantModel assistant,
    List<PlatformFile> files,
  ) async {
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

    // Upload files and get URLs (only if files exist)
    List<String> fileUrls = [];
    List<String> fileNames = [];
    if (files.isNotEmpty) {
      attachedFiles = files;

      final uploadResponse = await uploadFiles(files);
      fileUrls = uploadResponse.files.map((file) => file.url).toList();
      fileNames = uploadResponse.files.map((file) => file.name).toList();
      debugPrint("Files uploaded: $fileUrls");
    }


    // Create a user message and append
    final userMsg = ChatMessageModel.createMessage(
      trimmed,
      'user',
      fileUrls,
      fileNames: fileNames,
    );
    messages.add(userMsg);
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollToBottom();
    });
    _isStreaming = true;
    _isLoading = false;
    notifyListeners();

    try {
      final request = SendMessageRequestModel(
        content: trimmed,
        files: fileUrls,
        metadata: metadata,
        assistant: assistant,
        responseMode: 'streaming',
      );

      String fullMessage = '';
      ChatMessageModel? assistantMsg;
      bool firstChunk = true;

      await for (var chunk in chatUsecase.sendMessageStream(request)) {
        // Create assistant message on first chunk
        if (firstChunk) {
          assistantMsg = ChatMessageModel.createMessage('', 'assistant', []);
          messages.add(assistantMsg);
          firstChunk = false;
        }

        fullMessage += chunk;
        if (assistantMsg != null) {
          assistantMsg.content = fullMessage;
        }
        notifyListeners();
        scrollToBottom();
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

  Future<bool> chatWithBot(
    String content,
    AssistantModel assistant,
    List<PlatformFile> files,
  ) async {
    final trimmed = content.trim();
    // Validate message
    final validationError = validateInputMessage(trimmed, files);
    if (validationError.isNotEmpty) {
      errorSetter = validationError;
      return false;
    }

    List<String> fileUrls = [];
    List<String> fileNames = [];
    if (files.isNotEmpty) {
      attachedFiles = files;

      final uploadResponse = await uploadFiles(files);
      fileUrls = uploadResponse.files.map((file) => file.url).toList();
      fileNames = uploadResponse.files.map((file) => file.name).toList();
    }

    if (conversationId.isEmpty) {
      // New conversation - reset metadata
      conversationId = 'temp_id';
    }

    // Create a user message and append
    final userMsg = ChatMessageModel.createMessage(
      trimmed,
      'user',
      fileUrls,
      fileNames: fileNames,
    );
    messages.add(userMsg);
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollToBottom();
    });
    _isStreaming = true;
    _isLoading = false;
    notifyListeners();

    try {
      final request = ChatWithBotRequestModel(
        content: trimmed,
        files: fileUrls,
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
      messages.add(replyMessage);
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
      _isStreaming = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getConversationHistory(
    String assistantId,
    String assistantModel,
  ) async {
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

  String validateInputMessage(String content, List<PlatformFile> files) {
    final trimmed = content.trim();
    if (trimmed.isEmpty && files.isEmpty) {
      return "Please enter a message or select files to send.";
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
    _safeNotifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
