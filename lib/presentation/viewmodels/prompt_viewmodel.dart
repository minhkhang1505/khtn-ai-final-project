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

  // All Prompts State
  LoadMoreState _allLoadMoreState = LoadMoreState.idle;
  LoadMoreState get allLoadMoreState => _allLoadMoreState;
  double _allOffset = 0;
  bool _allHasNext = false;
  bool get allHasNext => _allHasNext;

  // Category Prompts State
  LoadMoreState _categoryLoadMoreState = LoadMoreState.idle;
  LoadMoreState get categoryLoadMoreState => _categoryLoadMoreState;
  double _categoryOffset = 0;
  bool _categoryHasNext = false;
  bool get categoryHasNext => _categoryHasNext;

  // Favorite Prompts State
  LoadMoreState _favoriteLoadMoreState = LoadMoreState.idle;
  LoadMoreState get favoriteLoadMoreState => _favoriteLoadMoreState;
  double _favoriteOffset = 0;
  bool _favoriteHasNext = false;
  bool get favoriteHasNext => _favoriteHasNext;

  // Private Prompts State
  LoadMoreState _privateLoadMoreState = LoadMoreState.idle;
  LoadMoreState get privateLoadMoreState => _privateLoadMoreState;
  double _privateOffset = 0;
  bool _privateHasNext = false;
  bool get privateHasNext => _privateHasNext;

  // Backward compatibility
  LoadMoreState get loadMoreState => _allLoadMoreState;
  bool get hasNext => _allHasNext;

  final List<PromptEntity> _prompts = [];
  List<PromptEntity>? get prompts => _prompts;

  final List<PromptEntity> _privatePrompts = [];
  List<PromptEntity>? get privatePrompts => _privatePrompts;

  final List<PromptEntity> _favoritePrompts = [];
  List<PromptEntity>? get favoritePrompts => _favoritePrompts;

  final List<PromptEntity> _categoryPrompts = [];
  List<PromptEntity>? get categoryPrompts => _categoryPrompts;

  double limit = 10;

  Future<bool> _fetchPrompts({
    CategoryType? category,
    bool isFavorite = false,
    bool resetOffset = false,
    bool isPublic = true,
  }) async {
    try {
      // Determine current state variables
      LoadMoreState currentLoadMoreState;
      if (isFavorite) {
        currentLoadMoreState = _favoriteLoadMoreState;
      } else if (category != null) {
        currentLoadMoreState = _categoryLoadMoreState;
      } else if (!isPublic) {
        currentLoadMoreState = _privateLoadMoreState;
      } else {
        currentLoadMoreState = _allLoadMoreState;
      }

      if (resetOffset) {
        if (_state == PromptViewState.loading) {
          return false; // Prevent multiple simultaneous fetches
        }
      } else {
        if (currentLoadMoreState == LoadMoreState.loading ||
            currentLoadMoreState == LoadMoreState.noMoreData) {
          return false;
        }
      }

      if (resetOffset) {
        _setState(PromptViewState.loading);

        // Reset specific state
        if (isFavorite) {
          _favoriteLoadMoreState = LoadMoreState.idle;
          _favoriteOffset = 0;
          _favoriteHasNext = false;
          _favoritePrompts.clear();
        } else if (category != null) {
          _categoryLoadMoreState = LoadMoreState.idle;
          _categoryOffset = 0;
          _categoryHasNext = false;
          _categoryPrompts.clear();
        } else if (!isPublic) {
          _privateLoadMoreState = LoadMoreState.idle;
          _privateOffset = 0;
          _privateHasNext = false;
          _privatePrompts.clear();
        } else {
          _allLoadMoreState = LoadMoreState.idle;
          _allOffset = 0;
          _allHasNext = false;
          _prompts.clear();
        }
        notifyListeners();
      } else {
        // Set loading state
        if (isFavorite) {
          _favoriteLoadMoreState = LoadMoreState.loading;
        } else if (category != null) {
          _categoryLoadMoreState = LoadMoreState.loading;
        } else if (!isPublic) {
          _privateLoadMoreState = LoadMoreState.loading;
        } else {
          _allLoadMoreState = LoadMoreState.loading;
        }
        notifyListeners();
      }

      // Get current offset for request
      double requestOffset;
      if (isFavorite) {
        requestOffset = _favoriteOffset;
      } else if (category != null) {
        requestOffset = _categoryOffset;
      } else if (!isPublic) {
        requestOffset = _privateOffset;
      } else {
        requestOffset = _allOffset;
      }

      final requestObject = PromptRequest(
        limit: limit,
        offset: requestOffset,
        category: category,
        isFavorite: isFavorite,
        isPublic: isPublic,
      );

      final response = await getPromptUseCase.call(requestObject);

      // Update state with response
      if (isFavorite) {
        _favoriteHasNext = response.hasNext;
        _favoriteOffset += limit;
        _favoritePrompts.addAll(response.items.toEntityList());
        _favoriteLoadMoreState = response.hasNext
            ? LoadMoreState.idle
            : LoadMoreState.noMoreData;
      } else if (category != null) {
        _categoryHasNext = response.hasNext;
        _categoryOffset += limit;
        _categoryPrompts.addAll(response.items.toEntityList());
        _categoryLoadMoreState = response.hasNext
            ? LoadMoreState.idle
            : LoadMoreState.noMoreData;
      } else if (!isPublic) {
        _privateHasNext = response.hasNext;
        _privateOffset += limit;
        _privatePrompts.addAll(response.items.toEntityList());
        _privateLoadMoreState = response.hasNext
            ? LoadMoreState.idle
            : LoadMoreState.noMoreData;
      } else {
        _allHasNext = response.hasNext;
        _allOffset += limit;
        _prompts.addAll(response.items.toEntityList());
        _allLoadMoreState = response.hasNext
            ? LoadMoreState.idle
            : LoadMoreState.noMoreData;
      }

      // Ensure favorite flags are consistent across lists
      _mergeFavoriteFlags();

      if (_state != PromptViewState.success) {
        _setState(PromptViewState.success);
      } else {
        notifyListeners();
      }

      return true;
    } catch (e) {
      debugPrint('PromptViewmodel: Error fetching prompts - $e');

      if (resetOffset) {
        _setState(PromptViewState.failure);
      } else {
        if (isFavorite) {
          _favoriteLoadMoreState = LoadMoreState.idle;
        } else if (category != null) {
          _categoryLoadMoreState = LoadMoreState.idle;
        } else if (!isPublic) {
          _privateLoadMoreState = LoadMoreState.idle;
        } else {
          _allLoadMoreState = LoadMoreState.idle;
        }
        notifyListeners();
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

  Future<bool> loadMoreFavoritePrompts() {
    return _fetchPrompts(isFavorite: true, resetOffset: false);
  }

  Future<bool> loadMorePrivatePrompts() {
    return _fetchPrompts(isPublic: false, resetOffset: false);
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

  // Merge favorite flags from _favoritePrompts into other lists (only sets true,
  // avoids incorrectly clearing if server data is partial)
  void _mergeFavoriteFlags() {
    final favIds = _favoritePrompts
        .where((p) => p.isFavorite)
        .map((p) => p.id)
        .toSet();

    void apply(List<PromptEntity> list) {
      for (var i = 0; i < list.length; i++) {
        final p = list[i];
        if (favIds.contains(p.id) && !p.isFavorite) {
          list[i] = p.copyWith(isFavorite: true);
        }
      }
    }

    apply(_prompts);
    apply(_privatePrompts);
    apply(_categoryPrompts);
  }
}
