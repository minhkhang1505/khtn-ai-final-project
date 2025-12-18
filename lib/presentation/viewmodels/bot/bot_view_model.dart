import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';

class BotViewModel extends ChangeNotifier {
  final List<BotModel> _bots = [];

  List<BotModel> get bots => _bots;
  
  // State variables for bot management can be added here
  List<BotModel> botList = [];
}