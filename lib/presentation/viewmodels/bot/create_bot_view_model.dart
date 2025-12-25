import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot/bot_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateBotViewModel extends ChangeNotifier {
  final BotUseCase botUseCase;

  CreateBotViewModel({required this.botUseCase}) {
    assistantNameController.addListener(_onAssistantNameChanged);
    instructionsController.addListener(notifyListeners);
    descriptionController.addListener(notifyListeners);
  }

  void _onAssistantNameChanged() {
    if (assistantNameError != null) {
      assistantNameError = null;
    }
    notifyListeners();
  }

  final TextEditingController assistantNameController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? assistantNameError;
  String? modelError;

  String? _selectedModelId;
  String? get selectedModelId => _selectedModelId;

  void setSelectedModel(String? modelId) {
    _selectedModelId = modelId;
    modelError = null;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> createBot() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final isNameValid = validateAssistantName();
    final isModelValid = validateModel();
    if (!isNameValid || !isModelValid) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      final BotRequestModel botRequest = BotRequestModel(
        assistantName: assistantNameController.text.trim(),
        instructions: instructionsController.text.trim(),
        description: descriptionController.text.trim(),
        model: _selectedModelId,
      );

      final createFuture = botUseCase.createBot(botRequest);
      await Future.delayed(const Duration(seconds: 1));
      await createFuture;

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  bool validateAssistantName() {
    final name = assistantNameController.text.trim();
    if (name.isEmpty) {
      assistantNameError = 'Bot name is required.';
      return false;
    } else if (name.length < 3) {
      assistantNameError = 'Bot name must be at least 3 characters.';
      return false;
    } else if (name.length > 100) {
      assistantNameError = 'Bot name must be at most 100 characters.';
      return false;
    } else {
      assistantNameError = null;
    }
    notifyListeners();
    return true;
  }

  bool validateModel() {
    if (_selectedModelId == null || _selectedModelId!.isEmpty) {
      modelError = 'AI model is required.';
      notifyListeners();
      return false;
    }
    modelError = null;
    notifyListeners();
    return true;
  }

  void clearForm() {
    assistantNameController.clear();
    instructionsController.clear();
    descriptionController.clear();
    _errorMessage = null;
    assistantNameError = null;
    modelError = null;
    _selectedModelId = null;
    notifyListeners();
  }

  @override
  void dispose() {
    assistantNameController.dispose();
    instructionsController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}