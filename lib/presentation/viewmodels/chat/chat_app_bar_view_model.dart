import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot_usecase.dart';

import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';

@lazySingleton
class ChatAppBarViewModel extends ChangeNotifier {
  final BotUseCase botUseCase;
  
  ChatAppBarViewModel({required this.botUseCase}) {
    initialize();
  }

  String conversationTitle = 'Chat';

  AssistantModel selectedAssistant = AssistantModel.defaults();

  bool isLoading = false;

  List<AssistantModelType> baseModels = [];

  final List<BotModel> userBots = [];

  void fetchBaseModels() {
    baseModels =  AssistantModelType.values.toList();
  }

  Future<void> fetchAvailableModels() async {
    // Fetch user-created bots
    final request = GetBotsRequestModel(
      q: '',
      offset: 0,
      limit: 10,
    );
    final bots = await botUseCase.getBots(request);
    userBots.addAll(bots.data.bots);
  }

  Future<void> initialize() async {
    isLoading = true;
    notifyListeners();

    fetchBaseModels();
    await fetchAvailableModels();

    isLoading = false;
    notifyListeners();
  }

  void setSelectedAssistant(AssistantModel assistant) {
    selectedAssistant = assistant;
    notifyListeners();
  }

  void setConversationTitle(String title) {
    conversationTitle = title;
    notifyListeners();
  }
}