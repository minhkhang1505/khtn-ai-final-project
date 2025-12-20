import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot_usecase.dart';

class BotViewModel extends ChangeNotifier {
  final BotUseCase botUseCase;

  BotViewModel({required this.botUseCase});

  final List<BotModel> _bots = [];
  List<BotModel> get bots => _bots;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading (bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _filter = 'all';
  String get filter => _filter;
  set filter (String value) {
    _filter = value;
    notifyListeners();
  }

  Future<void> fetchBots() async {
    isLoading = true;
    try {
      final request = GetBotsRequestModel(
        q: '',
        offset: 0,
        limit: 10,
      );

      switch (filter) {
        case 'name':
          request.orderField = 'assistantName';
          request.order = BotOrder.asc;
          break;
        case 'date':
          request.orderField = 'createdAt';
          request.order = BotOrder.desc;
          break;
        case 'favorite':
          request.isFavorite = true;
          break;
        case 'published':
          request.isPublished = true;
          break;
        default:
          // No additional filters
          break;
      }

      debugPrint('😁 Fetching bots with filter: $filter');

      final response = await botUseCase.getBots(request);
      _bots.clear();
      _bots.addAll(response.data.bots);
    } catch (e) {
      debugPrint('Failed to fetch bots: $e');
    } finally {
      isLoading = false;
    }
  }
}