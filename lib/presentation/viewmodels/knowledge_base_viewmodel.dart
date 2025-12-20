import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/mappers/knowledge_mapper.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/create_knowledge_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/get_knowledges_usecase.dart';

enum KnowledgeBaseState { initial, loading, success, failure }

class KnowledgeBaseViewmodel extends ChangeNotifier {
  GetKnowledgesUsecase getKnowledgesUsecase;

  KnowledgeBaseViewmodel({required this.getKnowledgesUsecase});
  KnowledgeBaseState _state = KnowledgeBaseState.initial;
  KnowledgeBaseState get state => _state;

  final List<KnowledgeEntity> _knowledges = [];
  List<KnowledgeEntity>? get knowledges => _knowledges;

  var hasNext = false;
  final loadMore = false;
  var offset = 0.0;
  final limit = 10.0;

  void _setState(KnowledgeBaseState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> _fetchKnowledges({bool resetOffset = false}) async {
    if (_state == KnowledgeBaseState.loading) return false;

    _setState(KnowledgeBaseState.loading);
    try {
      final response = await getKnowledgesUsecase(
        KnowledgeQuery(offset: offset, limit: limit),
      );

      // Map response data to entities using extension
      _knowledges.addAll(response.data.toEntityList());

      hasNext = response.meta.hasNext;
      offset += limit;

      _setState(KnowledgeBaseState.success);
      return true;
    } catch (e) {
      print('Error fetching knowledges: $e');
      _setState(KnowledgeBaseState.failure);
      return false;
    }
  }

  Future<bool> getAllKnowledges() => _fetchKnowledges();

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
