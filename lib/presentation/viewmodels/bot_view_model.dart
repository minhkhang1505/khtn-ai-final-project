import 'package:flutter/foundation.dart';
import 'package:khtn_ai_final_project/data/models/bot_model.dart';

class BotViewModel extends ChangeNotifier {
  final List<BotModel> _bots = [];

  List<BotModel> get bots => _bots;

  void loadBots() {
    _bots.addAll([
      BotModel(
        botName: 'Chat Assistant',
        botDescription: 'Helps with customer inquiries.',
        category: 'Customer Support',
        model: 'GPT-4',
        state: 'Active',
        prompt: 'Assist customers with their questions.',
      ),
      BotModel(
        botName: 'Sales Bot',
        botDescription: 'Automates sales follow-ups.',
        category: 'Sales',
        model: 'GPT-3.5',
        state: 'Inactive',
        prompt: 'Follow up with potential leads.',
      ),
    ]);
    notifyListeners();
  }
}
