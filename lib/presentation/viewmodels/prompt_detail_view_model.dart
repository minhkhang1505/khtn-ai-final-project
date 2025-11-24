import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/delete_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/get_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/udpate_prompt_usecase.dart';

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

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController contentController;

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

  Future<bool> loadPromptDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      final PromptRequest queryRequest = PromptRequest(query: promptId);
      final response = await getPromptUseCase.call(queryRequest);

      final currentPrompt = response.items[0];

      titleController.text = currentPrompt.title;
      descriptionController.text = currentPrompt.description ?? "";
      contentController.text = currentPrompt.content;
      _selectedCategory = currentPrompt.category;
      _selectedLanguage = currentPrompt.language;
      _isPublic = currentPrompt.isPublic;

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to load prompt details: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
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

  Future<bool> updatePrompt() async {
    try {
      final updateRequest = PromptCreationAndUpdateRequest(
        category: _selectedCategory,
        content: contentController.text,
        description: descriptionController.text,
        isPublic: _isPublic,
        language: _selectedLanguage,
        title: titleController.text,
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

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    contentController.dispose();
    super.dispose();
  }
}
