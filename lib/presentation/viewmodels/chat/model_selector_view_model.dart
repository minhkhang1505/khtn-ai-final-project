import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot_usecase.dart';

import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';

@injectable
class ModelSelectorViewModel extends ChangeNotifier {
  final BotUseCase botUseCase;
  
  ModelSelectorViewModel({required this.botUseCase}) {
    initialize();
  }

  String selectedModel = AssistantModelType.getModelId(AssistantModelType.GPT_4O_MINI);

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
    fetchBaseModels();
    await fetchAvailableModels();
    notifyListeners();
  }
}