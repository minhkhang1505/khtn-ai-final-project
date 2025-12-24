import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/mappers/knowledge_mapper.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/get_knowledges_usecase.dart';
import 'package:injectable/injectable.dart';

enum KnowledgeBaseState { initial, loading, success, failure }

@injectable
class KnowledgeBaseViewmodel extends ChangeNotifier {
  GetKnowledgesUsecase getKnowledgesUsecase;

  KnowledgeBaseViewmodel({required this.getKnowledgesUsecase});

  KnowledgeBaseState _state = KnowledgeBaseState.initial;
  KnowledgeBaseState get state => _state;

  final List<KnowledgeEntity> _knowledges = [];
  List<KnowledgeEntity>? get knowledges => _knowledges;

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
    KnowledgeOrder order = KnowledgeOrder.DESC,
    String? orderField,
  }) async {
    if (_state == KnowledgeBaseState.loading) return false;

    if (resetOffset) {
      offset = 0.0;
      hasNext = true;
      _knowledges.clear();
    }

    if (!hasNext) return false;

    _setState(KnowledgeBaseState.loading);
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

      _setState(KnowledgeBaseState.success);
      return true;
    } catch (e) {
      debugPrint('Error fetching knowledges: $e');
      _setState(KnowledgeBaseState.failure);
      return false;
    }
  }

  Future<bool> getAllKnowledges() => _fetchKnowledges();

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
}
