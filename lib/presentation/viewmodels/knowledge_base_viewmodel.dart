import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/mappers/knowledge_mapper.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';
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

      _knowledges.addAll(response.data.toEntityList());

      hasNext = response.meta.hasNext;
      offset += limit;

      _setState(KnowledgeBaseState.success);
      if (_state == KnowledgeBaseState.success) {
        for (var element in response.data) {
          print("Khang: ${element.knowledgeName}");
        }
      }
      return true;
    } catch (e) {
      _setState(KnowledgeBaseState.failure);
      return false;
    }
  }

  Future<bool> getAllKnowledges() => _fetchKnowledges();
}
