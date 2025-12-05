import 'package:flutter/foundation.dart';
import 'package:khtn_ai_final_project/core/constants/categories.dart';
import 'package:khtn_ai_final_project/data/mappers/prompt_mapper.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/add_prompt_to_fav.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/create_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/delete_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/get_prompt_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/remove_prompt_from_favorite.dart';

enum PromptViewState { initial, loading, success, failure }

class PromptViewmodel extends ChangeNotifier {
  final GetPromptUseCase getPromptUseCase;
  final CreatePromptUsecase createPromptUseCase;
  final DeletePromptUsecase deletePromptUseCase;
  final AddPromptToFavoriteUsecase addPromptToFavoriteUseCase;
  final RemovePromptFromFavoriteUsecase removePromptFromFavoriteUsecase;

  PromptViewmodel({
    required this.getPromptUseCase,
    required this.createPromptUseCase,
    required this.deletePromptUseCase,
    required this.addPromptToFavoriteUseCase,
    required this.removePromptFromFavoriteUsecase,
  });

  PromptViewState _state = PromptViewState.initial;
  PromptViewState get viewState => _state;

  void _setState(PromptViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  final List<PromptEntity> _prompts = [];
  List<PromptEntity>? get prompts => _prompts;

  final List<PromptEntity> _favoritePrompts = [];
  List<PromptEntity>? get favoritePrompts => _favoritePrompts;

  final List<PromptEntity> _categoryPrompts = [];
  List<PromptEntity>? get categoryPrompts => _categoryPrompts;

  double limit = 20;
  double offset = 0;
  bool hasNext = false;

  Future<bool> _fetchPrompts({
    CategoryType? category,
    bool isFavorite = false,
    bool resetOffset = false,
  }) async {
    try {
      _setState(PromptViewState.loading);
      if (resetOffset) {
        offset = 0;
        hasNext = false;

        if (isFavorite) {
          _favoritePrompts.clear();
        } else if (category != null) {
          _categoryPrompts.clear();
        } else {
          _prompts.clear();
        }
      }

      final requestObject = PromptRequest(
        limit: limit,
        offset: offset,
        category: category,
        isFavorite: isFavorite,
      );

      final response = await getPromptUseCase.call(requestObject);
      for (var item in response.items) {
        debugPrint('Khang - Fetched prompt: ${item.id} - ${item.title}');
      }
      hasNext = response.hasNext;
      offset += limit;

      if (isFavorite) {
        _favoritePrompts.addAll(response.items.toEntityList());
      } else if (category != null) {
        _categoryPrompts.addAll(response.items.toEntityList());
      } else {
        _prompts.addAll(response.items.toEntityList());
      }

      _setState(PromptViewState.success);

      return true;
    } catch (e) {
      debugPrint('PromptViewmodel: Error fetching prompts - $e');
      _setState(PromptViewState.failure);
      return false;
    }
  }

  Future<bool> getAllPrompts() => _fetchPrompts(resetOffset: true);

  Future<bool> getPromptByCategory(CategoryType category) =>
      _fetchPrompts(category: category, resetOffset: true);

  Future<bool> getFavoritePrompts() =>
      _fetchPrompts(isFavorite: true, resetOffset: true);

  Future<bool> createPrompt(PromptCreationAndUpdateRequest newPrompt) async {
    try {
      final response = await createPromptUseCase.call(newPrompt);
      return response;
    } catch (e) {
      debugPrint('PromptViewmodel: Error creating prompt - $e');
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> deletePrompt(String promptID) async {
    try {
      final response = await deletePromptUseCase.call(promptID);
      return response;
    } catch (e) {
      debugPrint('PromptViewmodel: Error deleting prompt - $e');
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> addPromptToFavorite(String promptId) async {
    try {
      final response = await addPromptToFavoriteUseCase.call(promptId);
      return response;
    } catch (e) {
      debugPrint('PromptViewmodel: Error adding prompt to favorite - $e');
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> removeFromFavorite(String promptId) async {
    try {
      final response = await removePromptFromFavoriteUsecase.call(promptId);
      return response;
    } catch (e) {
      debugPrint('PromptViewmodel: Error removing prompt from favorite - $e');
      return false;
    } finally {
      notifyListeners();
    }
  }
}
