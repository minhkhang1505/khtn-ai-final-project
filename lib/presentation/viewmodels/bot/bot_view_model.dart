import 'dart:async';
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

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasNext = true;
  bool get hasNext => _hasNext;

  int _offset = 0;
  final int _limit = 10;

  String _filter = 'all';
  String get filter => _filter;
  set filter (String value) {
    _filter = value;
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  
  Timer? _debounceTimer;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
    
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    // Start new timer for debounce (500ms)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _offset = 0;
      _hasNext = true;
      fetchBots();
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchBots() async {
    isLoading = true;
    _offset = 0;
    _hasNext = true;
    try {
      final request = GetBotsRequestModel(
        q: _searchQuery,
        order: BotOrder.asc,
        orderField: 'assistantName',
        offset: _offset,
        limit: _limit,
        isFavorite: false,
        isPublished: false,
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

      debugPrint('Fetching bots with filter: $filter, request: ${request.toJson()}');

      final response = await botUseCase.getBots(request);
      _bots.clear();
      _bots.addAll(response.data.bots);
      _offset = _limit;
      _hasNext = response.meta.hasNext;
    } catch (e) {
      debugPrint('Failed to fetch bots: $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> loadMoreBots() async {
    if (_isLoadingMore || !_hasNext || _isLoading) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      final request = GetBotsRequestModel(
        q: _searchQuery,
        order: BotOrder.asc,
        orderField: 'assistantName',
        offset: _offset,
        limit: _limit,
        isFavorite: false,
        isPublished: false,
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

      debugPrint('😁Fetching more bots with filter: $filter, request: ${request.toJson()}');

      final response = await botUseCase.getBots(request);

      debugPrint('😁Fetching more bots response: ${response.toJson()}');
      _bots.addAll(response.data.bots);
      _offset += _limit;
      _hasNext = response.meta.hasNext;
    } catch (e) {
      debugPrint('Failed to load more bots: $e');
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}