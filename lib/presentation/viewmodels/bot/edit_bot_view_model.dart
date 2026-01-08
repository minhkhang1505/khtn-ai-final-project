import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot/bot_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
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
  final ValueNotifier<bool> isFavoriteNotifier = ValueNotifier<bool>(false);

  String? assistantNameError;

  late BotModel _bot;
  BotModel? _botNullable;
  
  BotModel get bot => _bot;

  bool get isFavorite => _botNullable?.isFavorite ?? false;

  void setupBot(BotModel bot) {
    _isDataLoading = true;
    notifyListeners();
    _bot = bot;
    _botNullable = bot;
    isFavoriteNotifier.value = bot.isFavorite;
    assistantNameController.text = bot.assistantName;
    instructionsController.text = bot.instructions;
    descriptionController.text = bot.description;

    // Data setup complete
    _isDataLoading = false;
    notifyListeners();
  }

  bool _isDataLoading = false;
  bool get isDataLoading => _isDataLoading;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updateBot() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (!validateAssistantName()) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      final BotRequestModel botRequest = BotRequestModel(
        assistantName: assistantNameController.text.trim(),
        instructions: instructionsController.text.trim(),
        description: descriptionController.text.trim(),
      );
      
      final updateFuture = botUseCase.updateBot(_bot.id, botRequest);
      await Future.delayed(const Duration(seconds: 1));
      await updateFuture;

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
      final deleteFuture = botUseCase.deleteBot(_bot.id);
      await Future.delayed(const Duration(seconds: 1));
      await deleteFuture;

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

  Future<void> toggleFavorite() async {
    try {
      final newFavoriteState = !_bot.isFavorite;

      final updatedBot = await botUseCase.toggleFavorite(_bot.id);
      _bot = updatedBot;
      _botNullable = updatedBot;
      isFavoriteNotifier.value = newFavoriteState;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Failed to toggle favorite: $e');
      notifyListeners();
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