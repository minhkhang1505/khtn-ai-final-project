import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/categories.dart';
import 'package:khtn_ai_final_project/core/constants/languages.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/create_prompt_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreatePromptViewModel extends ChangeNotifier {
  final CreatePromptUsecase createPromptUseCase;

  CreatePromptViewModel({required this.createPromptUseCase}) {
    // Listen to changes for live preview
    titleController.addListener(notifyListeners);
    contentController.addListener(notifyListeners);
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  String _selectedCategory = categories.last.id.name;
  String get selectedCategory => _selectedCategory;

  String _selectedLanguage = languages.first.name;
  String get selectedLanguage => _selectedLanguage;

  bool _isPublic = true;
  bool get isPublic => _isPublic;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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

  Future<bool> savePrompt() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = PromptCreationAndUpdateRequest(
        category: _selectedCategory,
        content: contentController.text,
        description: descriptionController.text,
        isPublic: _isPublic,
        language: _selectedLanguage,
        title: titleController.text,
      );

      final success = await createPromptUseCase.call(request);

      if (!success) {
        _errorMessage = 'Failed to create prompt';
      }

      return success;
    } catch (e) {
      _errorMessage = 'Error: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    contentController.clear();
    _selectedCategory = categories.last.id.name;
    _selectedLanguage = languages.first.name;
    _isPublic = true;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    contentController.dispose();
    super.dispose();
  }
}
