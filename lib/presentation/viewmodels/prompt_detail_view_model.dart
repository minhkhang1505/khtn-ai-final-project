import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/delete_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/get_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/udpate_prompt_usecase.dart';

enum PromptDetailState { initial, loading, success, failure }

class PromptDetailViewModel extends ChangeNotifier {
  final GetPromptUseCase getPromptUseCase;
  final UpdatePromptUsecase updatePromptUseCase;
  final DeletePromptUsecase deletePromptUseCase;
  final String promptId;

  PromptDetailViewModel({
    required this.getPromptUseCase,
    required this.updatePromptUseCase,
    required this.deletePromptUseCase,
    required this.promptId,
  });

  PromptDetailState _promptDetailState = PromptDetailState.initial;
  PromptDetailState get promptDetailState => _promptDetailState;

  // Domain/UI state only (no controllers)
  String _title = '';
  String get title => _title;

  String _description = '';
  String get description => _description;

  String _content = '';
  String get content => _content;

  late String _selectedCategory;
  String get selectedCategory => _selectedCategory;

  late String _selectedLanguage;
  String get selectedLanguage => _selectedLanguage;

  bool _isPublic = true;
  bool get isPublic => _isPublic;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void setIsPublic(bool isPublic) {
    _isPublic = isPublic;
    notifyListeners();
  }

  void clearItem() {
    _title = '';
    _description = '';
    _content = '';
    _selectedCategory = '';
    _selectedLanguage = '';
    _isPublic = true;
    _errorMessage = '';
    notifyListeners();
  }

  void _setState(PromptDetailState state) {
    _promptDetailState = state;
    notifyListeners();
  }

  Future<bool> loadPromptDetails() async {
    try {
      _setState(PromptDetailState.loading);
      if (promptId.isEmpty || promptId == 'unknown') {
        _errorMessage = 'Invalid prompt ID: $promptId';
        debugPrint('Khang - Error: Invalid prompt ID: $promptId');
        _setState(PromptDetailState.failure);
        return false;
      }

      debugPrint('Khang - Loading prompt details for ID: $promptId');
      final PromptRequest queryRequest = PromptRequest(
        id: promptId,
        limit: 1,
        offset: 0,
      );

      final response = await getPromptUseCase.call(queryRequest);

      if (response.items.isEmpty) {
        _errorMessage = 'Prompt not found';
        _setState(PromptDetailState.failure);
        return false;
      }

      final currentPrompt = response.items[0];

      for (var item in response.items) {
        debugPrint('Khang - Fetched prompt item: ${item.id} - ${item.title}');
      }

      _title = currentPrompt.title;
      _description = currentPrompt.description ?? "";
      _content = currentPrompt.content;
      _selectedCategory = currentPrompt.category;
      _selectedLanguage = currentPrompt.language;
      _isPublic = currentPrompt.isPublic;

      _setState(PromptDetailState.success);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to load prompt details: $e';
      _setState(PromptDetailState.failure);
      return false;
    }
  }

  Future<bool> deletePrompt() async {
    try {
      final success = await deletePromptUseCase.call(promptId);
      return success;
    } catch (e) {
      _errorMessage = 'Failed to delete prompt: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updatePrompt({
    required String title,
    required String description,
    required String content,
  }) async {
    try {
      final updateRequest = PromptCreationAndUpdateRequest(
        category: _selectedCategory,
        content: content,
        description: description,
        isPublic: _isPublic,
        language: _selectedLanguage,
        title: title,
      );

      final response = await updatePromptUseCase.call(promptId, updateRequest);
      return response;
    } catch (e) {
      _errorMessage = 'Failed to update prompt: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
