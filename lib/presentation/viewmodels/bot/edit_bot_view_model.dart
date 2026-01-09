import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/bot/bot_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/get_knowledges_usecase.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:injectable/injectable.dart';


enum KnowledgeBaseState { initial, loading, success, failure }
enum LoadMoreUserKnowledgeState { idle, loading, noMore }

@injectable
class EditBotViewModel extends ChangeNotifier {
  final BotUseCase botUseCase;
  final GetKnowledgesUsecase getKnowledgesUsecase;

  EditBotViewModel({required this.botUseCase, required this.getKnowledgesUsecase}) {
    assistantNameController.addListener(notifyListeners);
    instructionsController.addListener(notifyListeners);
    descriptionController.addListener(notifyListeners);
  }

  final TextEditingController assistantNameController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ValueNotifier<bool> isFavoriteNotifier = ValueNotifier<bool>(false);

  final KnowledgeBaseState _state = KnowledgeBaseState.initial;
  KnowledgeBaseState get state => _state;

  String? assistantNameError;

  late BotModel _bot;
  BotModel? _botNullable;

  BotModel get bot => _bot;

  bool get isFavorite => _botNullable?.isFavorite ?? false;

  List<KnowledgeResDto> knowledges = [];

  List<KnowledgeEntity> userKnowledges = [];
  bool _isUserKnowledgeLoading = false;
  bool get isUserKnowledgeLoading => _isUserKnowledgeLoading;

  LoadMoreUserKnowledgeState _loadMoreUserKnowledgeState = LoadMoreUserKnowledgeState.idle;
  LoadMoreUserKnowledgeState get loadMoreUserKnowledgeState => _loadMoreUserKnowledgeState;

  var _userKnowledgeHasNext = true;
  var _userKnowledgeOffset = 0.0;
  final _userKnowledgeLimit = 20.0;

  Future<void> setupBot(BotModel bot) async {
    _isDataLoading = true;
    notifyListeners();
    _bot = bot;
    _botNullable = bot;
    isFavoriteNotifier.value = bot.isFavorite;
    assistantNameController.text = bot.assistantName;
    instructionsController.text = bot.instructions;
    descriptionController.text = bot.description;

    await getBotKnowledges();

    // Data setup complete
    _isDataLoading = false;
    notifyListeners();
  }

  bool _isDataLoading = false;
  bool get isDataLoading => _isDataLoading;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isKnowledgeLoading = false;
  bool get isKnowledgeLoading => _isKnowledgeLoading;

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

  Future<bool> addKnowledgeToBot(String knowledgeId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await botUseCase.addKnowledgeToAssistant(_bot.id, knowledgeId);

      await getBotKnowledges();

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

  Future<bool> removeKnowledgeFromBot(String knowledgeId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await botUseCase.removeKnowledgeFromAssistant(_bot.id, knowledgeId);

      await getBotKnowledges();

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

  Future<void> getBotKnowledges() async {
    _isKnowledgeLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await botUseCase.getAssistantKnowledges(_bot.id);
      knowledges = response.data;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isKnowledgeLoading = false;
      notifyListeners();
    }
  }

  Future<void> getUserKnowledges() async {
    _isUserKnowledgeLoading = true;
    _errorMessage = null;
    _userKnowledgeOffset = 0.0;
    _userKnowledgeHasNext = true;
    userKnowledges.clear();
    notifyListeners();

    try {
      await _fetchUserKnowledges(resetOffset: true);
      _isUserKnowledgeLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isUserKnowledgeLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchUserKnowledges({bool resetOffset = false, bool isLoadMore = false}) async {
    if (resetOffset) {
      _userKnowledgeOffset = 0.0;
      _userKnowledgeHasNext = true;
      userKnowledges.clear();
    }

    if (!_userKnowledgeHasNext) return;

    try {
      final query = KnowledgeQuery(
        limit: _userKnowledgeLimit,
        offset: _userKnowledgeOffset,
      );
      final response = await getKnowledgesUsecase(query);
      
      final newKnowledges = response.data.map((dto) => KnowledgeEntity(
        id: dto.id,
        userId: dto.userId,
        knowledgeName: dto.knowledgeName,
        description: dto.description,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
        createdBy: dto.createdBy,
        updatedBy: dto.updatedBy,
      )).toList();

      userKnowledges.addAll(newKnowledges);
      _userKnowledgeHasNext = response.meta.hasNext;
      _userKnowledgeOffset += _userKnowledgeLimit;

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error fetching user knowledges: $e');
      rethrow;
    }
  }

  Future<void> loadMoreUserKnowledges() async {
    if (_loadMoreUserKnowledgeState == LoadMoreUserKnowledgeState.loading || !_userKnowledgeHasNext) {
      return;
    }

    _loadMoreUserKnowledgeState = LoadMoreUserKnowledgeState.loading;
    notifyListeners();

    await _fetchUserKnowledges(isLoadMore: true);

    _loadMoreUserKnowledgeState = _userKnowledgeHasNext
        ? LoadMoreUserKnowledgeState.idle
        : LoadMoreUserKnowledgeState.noMore;
    notifyListeners();
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
