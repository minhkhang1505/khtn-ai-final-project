import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot_model.dart';

class BotViewModel extends ChangeNotifier {
  final List<BotModel> _bots = [];

  List<BotModel> get bots => _bots;

  void loadBots() {
    _bots.addAll([
      BotModel(
        id: '1',
        name: 'Chat Assistant',
        description: 'Helps with customer inquiries.',
        category: 'Customer Support',
        model: 'GPT-4',
        status: 'Active',
        prompt: 'Assist customers with their questions.',
        visibility: true,
        subagents: [],
      ),
      BotModel(
        id: '2',
        name: 'Sales Bot',
        description: 'Automates sales follow-ups.',
        category: 'Sales',
        model: 'GPT-3.5',
        status: 'Inactive',
        prompt: 'Follow up with potential leads.',
        visibility: false,
        subagents: [],
      ),
      BotModel(
        id: '3',
        name: 'Chat Assistant',
        description: 'Helps with customer inquiries.',
        category: 'Customer Support',
        model: 'GPT-4',
        status: 'Active',
        prompt: 'Assist customers with their questions.',
        visibility: true,
        subagents: [],
      ),
      BotModel(
        id: '4',
        name: 'Sales Bot',
        description: 'Automates sales follow-ups.',
        category: 'Sales',
        model: 'GPT-3.5',
        status: 'Inactive',
        prompt: 'Follow up with potential leads.',
        visibility: false,
        subagents: [],
      ),
    ]);
    notifyListeners();
  }
}