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

enum LoadMoreState { idle, loading, noMoreData }

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

  CategoryType? _currentSelectedCategory;

  PromptViewState _state = PromptViewState.initial;
  PromptViewState get viewState => _state;

  void _setState(PromptViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  LoadMoreState _loadMoreState = LoadMoreState.idle;
  LoadMoreState get loadMoreState => _loadMoreState;

  void _setLoadMoreState(LoadMoreState loadMoreState) {
    _loadMoreState = loadMoreState;
    notifyListeners();
  }

  final List<PromptEntity> _prompts = [];
  List<PromptEntity>? get prompts => _prompts;

  final List<PromptEntity> _privatePrompts = [];
  List<PromptEntity>? get privatePrompts => _privatePrompts;

  final List<PromptEntity> _favoritePrompts = [];
  List<PromptEntity>? get favoritePrompts => _favoritePrompts;

  final List<PromptEntity> _categoryPrompts = [];
  List<PromptEntity>? get categoryPrompts => _categoryPrompts;

  double limit = 10;
  double offset = 0;
  bool hasNext = false;

  Future<bool> _fetchPrompts({
    CategoryType? category,
    bool isFavorite = false,
    bool resetOffset = false,
    bool isPublic = true,
  }) async {
    try {
      if (resetOffset) {
        if (_state == PromptViewState.loading) {
          return false; // Prevent multiple simultaneous fetches
        }
      } else {
        if (_loadMoreState == LoadMoreState.loading ||
            _loadMoreState == LoadMoreState.noMoreData) {
          return false;
        }
      }

      if (resetOffset) {
        _setState(PromptViewState.loading);
        _setLoadMoreState(LoadMoreState.idle);

        offset = 0;
        hasNext = false;

        if (isFavorite) {
          _favoritePrompts.clear();
        } else if (category != null) {
          _categoryPrompts.clear();
        } else {
          _prompts.clear();
        }
      } else {
        _setLoadMoreState(LoadMoreState.loading);
      }

      final requestObject = PromptRequest(
        limit: limit,
        offset: offset,
        category: category,
        isFavorite: isFavorite,
        isPublic: isPublic,
      );

      final response = await getPromptUseCase.call(requestObject);

      hasNext = response.hasNext;
      offset += limit;

      if (isFavorite) {
        _favoritePrompts.addAll(response.items.toEntityList());
      } else if (category != null) {
        _categoryPrompts.addAll(response.items.toEntityList());
      } else {
        _prompts.addAll(response.items.toEntityList());
      }

      if (_state != PromptViewState.success) {
        _setState(PromptViewState.success);
      }

      if (hasNext) {
        _setLoadMoreState(LoadMoreState.idle);
      } else {
        _setLoadMoreState(LoadMoreState.noMoreData);
      }

      return true;
    } catch (e) {
      debugPrint('PromptViewmodel: Error fetching prompts - $e');

      if (resetOffset) {
        _setState(PromptViewState.failure);
      } else {
        _setLoadMoreState(LoadMoreState.idle);
      }
      return false;
    }
  }

  Future<bool> getAllPrompts() => _fetchPrompts(resetOffset: true);

  Future<bool> getPrivatePrompts() =>
      _fetchPrompts(isPublic: false, resetOffset: true);

  Future<bool> getPromptByCategory(CategoryType category) {
    _currentSelectedCategory = category;
    return _fetchPrompts(category: category, resetOffset: true);
  }

  Future<bool> getFavoritePrompts() =>
      _fetchPrompts(isFavorite: true, resetOffset: true);

  Future<bool> refreshPrompts() {
    _prompts.clear();
    return _fetchPrompts(resetOffset: true);
  }

  Future<bool> refreshFavoritePrompts() {
    _favoritePrompts.clear();
    return _fetchPrompts(isFavorite: true, resetOffset: true);
  }

  Future<bool> refreshCategoryPrompts() {
    _categoryPrompts.clear();
    return _fetchPrompts(category: _currentSelectedCategory, resetOffset: true);
  }

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

  Future<bool> loadMorePrompts() {
    return _fetchPrompts(resetOffset: false);
  }

  Future<bool> loadMoreCategoryPrompts() {
    return _fetchPrompts(
      category: _currentSelectedCategory,
      resetOffset: false,
    );
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
      if (response) {
        _applyFavoriteChange(promptId, true);
      }
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
      if (response) {
        _applyFavoriteChange(promptId, false);
      }
      return response;
    } catch (e) {
      debugPrint('PromptViewmodel: Error removing prompt from favorite - $e');
      return false;
    } finally {
      notifyListeners();
    }
  }

  // Keep lists in sync when favorite state changes
  void _applyFavoriteChange(String promptId, bool isFavorite) {
    void updateIn(List<PromptEntity> list) {
      final idx = list.indexWhere((p) => p.id == promptId);
      if (idx != -1) {
        list[idx] = list[idx].copyWith(isFavorite: isFavorite);
      }
    }

    // Update all known collections
    updateIn(_prompts);
    updateIn(_privatePrompts);
    updateIn(_categoryPrompts);

    // Maintain the favorites collection content
    final favIndex = _favoritePrompts.indexWhere((p) => p.id == promptId);
    if (isFavorite) {
      if (favIndex != -1) {
        // Ensure the stored item reflects the new state
        _favoritePrompts[favIndex] = _favoritePrompts[favIndex].copyWith(
          isFavorite: true,
        );
      } else {
        // Try to source the entity from other lists
        PromptEntity? src;
        final a = _prompts.firstWhere(
          (p) => p.id == promptId,
          orElse: () => _categoryPrompts.firstWhere(
            (p) => p.id == promptId,
            orElse: () => _privatePrompts.firstWhere(
              (p) => p.id == promptId,
              orElse: () => PromptEntity(
                id: '',
                createdAt: '',
                updatedAt: '',
                category: '',
                content: '',
                isPublic: true,
                language: '',
                title: '',
                userId: '',
                userName: '',
                isFavorite: true,
                createdBy: '',
                updatedBy: '',
              ),
            ),
          ),
        );
        if (a.id.isNotEmpty) {
          src = a.copyWith(isFavorite: true);
        }
        if (src != null) {
          _favoritePrompts.insert(0, src);
        }
      }
    } else {
      if (favIndex != -1) {
        _favoritePrompts.removeAt(favIndex);
      }
    }
  }
}
