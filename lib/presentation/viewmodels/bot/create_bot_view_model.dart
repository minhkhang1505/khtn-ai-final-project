import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot_usecase.dart';

class CreateBotViewModel extends ChangeNotifier {
  final BotUseCase botUseCase;

  CreateBotViewModel({required this.botUseCase}) {
    assistantNameController.addListener(notifyListeners);
    instructionsController.addListener(notifyListeners);
    descriptionController.addListener(notifyListeners);
  }

  final TextEditingController assistantNameController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> createBot() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final BotRequestModel botRequest = BotRequestModel(
        assistantName: assistantNameController.text.trim(),
        instructions: instructionsController.text.trim(),
        description: descriptionController.text.trim(),
      );
      await botUseCase.createBot(botRequest);

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

  void clearForm() {
    assistantNameController.clear();
    instructionsController.clear();
    descriptionController.clear();
    _errorMessage = null;
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