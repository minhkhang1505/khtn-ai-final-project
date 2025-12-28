import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/mappers/knowledge_mapper.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/delete_knowledge_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/get_knowledges_usecase.dart';
import 'package:injectable/injectable.dart';

enum KnowledgeBaseState { initial, loading, success, failure }

enum LoadMoreKnowledgeState { idle, loading, noMore }

enum DeleteKnowledgeState { initial, loading, success, failure }

@injectable
class KnowledgeBaseViewmodel extends ChangeNotifier {
  GetKnowledgesUsecase getKnowledgesUsecase;
  final DeleteKnowledgeBaseUsecase deleteKnowledgeBaseUsecase;

  KnowledgeBaseViewmodel({
    required this.getKnowledgesUsecase,
    required this.deleteKnowledgeBaseUsecase,
  });

  KnowledgeBaseState _state = KnowledgeBaseState.initial;
  KnowledgeBaseState get state => _state;

  final List<KnowledgeEntity> _knowledges = [];
  List<KnowledgeEntity>? get knowledges => _knowledges;

  LoadMoreKnowledgeState _loadMoreState = LoadMoreKnowledgeState.idle;
  LoadMoreKnowledgeState get loadMoreState => _loadMoreState;

  DeleteKnowledgeState _deleteState = DeleteKnowledgeState.initial;
  DeleteKnowledgeState get deleteState => _deleteState;

  void _setDeleteState(DeleteKnowledgeState newState) {
    _deleteState = newState;
    notifyListeners();
  }

  var hasNext = true;
  final loadMore = false;
  var offset = 0.0;
  final limit = 10.0;

  void _setState(KnowledgeBaseState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> _fetchKnowledges({
    bool resetOffset = false,
    bool isLoadMore = false,
    KnowledgeOrder order = KnowledgeOrder.DESC,
    String? orderField,
  }) async {
    if (_state == KnowledgeBaseState.loading && !isLoadMore) return false;

    if (resetOffset) {
      offset = 0.0;
      hasNext = true;
      _knowledges.clear();
    }

    if (!hasNext) return false;

    // Chỉ thay đổi state chính khi không phải load more
    if (!isLoadMore) {
      _setState(KnowledgeBaseState.loading);
    }

    try {
      final response = await getKnowledgesUsecase(
        KnowledgeQuery(
          offset: offset,
          limit: limit,
          order: order,
          orderField: orderField,
        ),
      );

      // Map response data to entities using extension
      _knowledges.addAll(response.data.toEntityList());

      hasNext = response.meta.hasNext;
      offset += limit;

      // Chỉ thay đổi state chính khi không phải load more
      if (!isLoadMore) {
        _setState(KnowledgeBaseState.success);
      } else {
        notifyListeners(); // Chỉ notify để update UI, không đổi state
      }
      return true;
    } catch (e) {
      debugPrint('Error fetching knowledges: $e');
      if (!isLoadMore) {
        _setState(KnowledgeBaseState.failure);
      }
      return false;
    }
  }

  Future<bool> getAllKnowledges() => _fetchKnowledges();

  Future<bool> loadMoreKnowledges() async {
    if (_loadMoreState == LoadMoreKnowledgeState.loading || !hasNext) {
      return false;
    }

    _loadMoreState = LoadMoreKnowledgeState.loading;
    notifyListeners();

    final success = await _fetchKnowledges(
      resetOffset: false,
      isLoadMore: true,
    );

    _loadMoreState = hasNext
        ? LoadMoreKnowledgeState.idle
        : LoadMoreKnowledgeState.noMore;
    notifyListeners();

    return success;
  }

  Future<bool> sortKnowledgesBy(KnowledgeOrder order) =>
      _fetchKnowledges(order: order, resetOffset: true);

  Future<bool> sortKnowledgesByField(String orderField) =>
      _fetchKnowledges(orderField: orderField, resetOffset: true);

  /// Force reloading from the first page and clearing current cached list.
  Future<bool> refreshKnowledges() => _fetchKnowledges(resetOffset: true);

  Future<bool> createNewKnowledge(KnowledgeEntity knowledge) async {
    // Implement the logic to create a new knowledge entry
    // This is a placeholder implementation
    try {
      // Simulate network call
      await Future.delayed(const Duration(seconds: 1));
      _knowledges.add(knowledge);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteKnowledge(String id) async {
    if (_state == DeleteKnowledgeState.loading) return false;

    try {
      _setDeleteState(DeleteKnowledgeState.loading);

      final success = await deleteKnowledgeBaseUsecase.call(id);

      if (success) {
        _setDeleteState(DeleteKnowledgeState.success);
      } else {
        _setDeleteState(DeleteKnowledgeState.failure);
      }
      return success;
    } catch (e) {
      debugPrint('Error deleting knowledge: $e');
      _setDeleteState(DeleteKnowledgeState.failure);
      return false;
    }
  }
}
