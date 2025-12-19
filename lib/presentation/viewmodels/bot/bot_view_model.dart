import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot_usecase.dart';

class BotViewModel extends ChangeNotifier {
  final BotUseCase botUseCase;

  BotViewModel({required this.botUseCase}) {
    fetchBots();
  }

  final List<BotModel> _bots = [];
  String filter = 'all';

  List<BotModel> get bots => _bots;

  Future<void> fetchBots() async {
    try {
      final request = GetBotsRequestModel(
        q: '',
        order: BotOrder.desc,
        order_field: 'createdAt',
        offset: 0,
        limit: 10,
        // Do not send is_favorite/is_published unless explicitly filtering
      );
      final response = await botUseCase.getBots(request);
      debugPrint('Fetched ${response.meta.total} bots from API.');
      debugPrint('Bot data: ${response.data.bots}');
      // Print empty line for better visibility in logs
      for (int i = 0; i < 3; i++) {
        debugPrint('\n');
        debugPrint('');
      }

      _bots.clear();
      _bots.addAll(response.data.bots);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to fetch bots: $e');
    }
  }
  
  // State variables for bot management can be added here
  List<BotModel> botList = [];
}