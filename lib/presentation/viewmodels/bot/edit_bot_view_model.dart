import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot_usecase.dart';

class EditBotViewModel extends ChangeNotifier {
  final BotUseCase botUseCase;

  EditBotViewModel({required this.botUseCase}) {
    assistantNameController.addListener(notifyListeners);
    instructionsController.addListener(notifyListeners);
    descriptionController.addListener(notifyListeners);
  }

  final TextEditingController assistantNameController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late BotModel bot;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> loadBotData(String botId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await botUseCase.getBotById(botId);
      bot = response;

      // Populate controllers with fetched data
      assistantNameController.text = bot.assistantName;
      instructionsController.text = bot.instructions;
      descriptionController.text = bot.description;

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

  Future<bool> updateBot() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final BotRequestModel botRequest = BotRequestModel(
        assistantName: assistantNameController.text.trim(),
        instructions: instructionsController.text.trim(),
        description: descriptionController.text.trim(),
      );
      await botUseCase.updateBot(bot.id, botRequest);

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

  Future<bool> deleteBot() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await botUseCase.deleteBot(bot.id);

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