import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/delete_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/get_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/udpate_prompt_usecase.dart';

enum PromptDetailState { initial, loading, success, failure }

class PromptDetailViewModel extends ChangeNotifier {
  final GetPromptUseCase getPromptUseCase;
  final UpdatePromptUsecase updatePromptUseCase;
  final DeletePromptUsecase deletePromptUseCase;
  final PromptEntity prompt;

  PromptDetailViewModel({
    required this.getPromptUseCase,
    required this.updatePromptUseCase,
    required this.deletePromptUseCase,
    required this.prompt,
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

      if (prompt.id.isEmpty) {
        _errorMessage = 'Invalid prompt ID: $prompt';
        debugPrint('Khang - Error: Invalid prompt ID: $prompt');
        _setState(PromptDetailState.failure);
        return false;
      }

      debugPrint('Khang - Loading prompt details for ID: ${prompt.id}');

      _title = prompt.title;
      _description = prompt.description ?? "";
      _content = prompt.content;
      _selectedCategory = prompt.category;
      _selectedLanguage = prompt.language;
      _isPublic = prompt.isPublic;

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
      _setState(PromptDetailState.loading);
      final success = await deletePromptUseCase.call(prompt.id);
      _setState(PromptDetailState.success);
      return success;
    } catch (e) {
      _errorMessage = 'Failed to delete prompt: $e';
      _setState(PromptDetailState.failure);
      return false;
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

      final response = await updatePromptUseCase.call(prompt.id, updateRequest);
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
