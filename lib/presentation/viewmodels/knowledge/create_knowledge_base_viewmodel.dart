import 'package:khtn_ai_final_project/data/models/Knowledge/knowledge_query.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/create_knowledge_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

enum CreateKnowledgeBaseState { initial, loading, success, failure }

@injectable
class CreateKnowledgeBaseViewmodel extends ChangeNotifier {
  CreateKnowledgeUsecase createKnowledgeUsecase;
  CreateKnowledgeBaseViewmodel({required this.createKnowledgeUsecase});

  CreateKnowledgeBaseState _state = CreateKnowledgeBaseState.initial;
  CreateKnowledgeBaseState get state => _state;

  void _setState(CreateKnowledgeBaseState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> createNewKnowledge(
    String knowledgeName,
    String description,
  ) async {
    if (_state == CreateKnowledgeBaseState.loading) {
      return false;
    }

    try {
      _setState(CreateKnowledgeBaseState.loading);

      final request = KnowledgeBaseCreationAndUpdateRequest(
        knowledgeName: knowledgeName,
        description: description,
      );

      final result = await createKnowledgeUsecase.call(request);

      if (result.id.isNotEmpty) {
        _setState(CreateKnowledgeBaseState.success);
        return true;
      } else {
        _setState(CreateKnowledgeBaseState.failure);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
