import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot_usecase.dart';

import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';

@injectable
class ModelSelectorViewModel extends ChangeNotifier {
  final BotUseCase botUseCase;
  
  ModelSelectorViewModel({required this.botUseCase});

  String selectedModel = AssistantModelType.getModelId(AssistantModelType.GPT_4O_MINI);

  final List<String> modelIds = [];

  List<String> fetchBaseModels() {
    final baseModels = AssistantModelType.values.toList();
    return baseModels.map((e) => e.id).toList();
  }

  Future<List<String>> fetchAvailableModels() async {
    // Fetch user-created bots
    final request = GetBotsRequestModel(
      q: '',
      offset: 0,
      limit: 10,
    );
    final bots = await botUseCase.getBots(request);
    return bots.data.bots.map((bot) => bot.model?.id ?? '').toList();
  }

  Future<void> initialize() async {
    modelIds.addAll(fetchBaseModels());
    modelIds.addAll(await fetchAvailableModels());
    notifyListeners();
  }
}