import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';
import 'package:khtn_ai_final_project/domain/models/knowledge_source_type.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/delete_knowledge_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/knowledge/update_knowledge_usecase.dart';
import 'package:injectable/injectable.dart';

enum KnowledgeDetailState { initial, loading, success, failure }

@injectable
class KnowledgeDetailViewmodel extends ChangeNotifier {
  final KnowledgeEntity knowledge;
  final UpdateKnowledgeBaseUsecase updateKnowledgeBaseUsecase;
  final DeleteKnowledgeBaseUsecase deleteKnowledgeBaseUsecase;

  @factoryMethod
  KnowledgeDetailViewmodel({
    @factoryParam required this.knowledge,
    required this.updateKnowledgeBaseUsecase,
    required this.deleteKnowledgeBaseUsecase,
  });

  KnowledgeDetailState _state = KnowledgeDetailState.initial;
  KnowledgeDetailState get state => _state;

  String _knowledgeName = "";
  String get knowledgeName => _knowledgeName;

  void setKnowledgeName(String name) {
    _knowledgeName = name;
    notifyListeners();
  }

  String _knowledgeDescription = "";
  String get knowledgeDescription => _knowledgeDescription;

  void setKnowledgeDescription(String description) {
    _knowledgeDescription = description;
    notifyListeners();
  }

  String _url = "";
  String get url => _url;

  void setUrl(String url) {
    _url = url;
    notifyListeners();
  }

  void clearItem() {
    _knowledgeName = "";
    _knowledgeDescription = "";
    _url = "";
    notifyListeners();
  }

  KnowledgeSourceType _sourceType = KnowledgeSourceTypes.url;
  KnowledgeSourceType get sourceType => _sourceType;

  void setSourceType(KnowledgeSourceType type) {
    _sourceType = type;
    notifyListeners();
  }

  void _setState(KnowledgeDetailState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> updateKnowledge() async {
    if (_state == KnowledgeDetailState.loading) return false;

    try {
      _setState(KnowledgeDetailState.loading);

      final updatedKnowledge = KnowledgeEntity(
        id: knowledge.id,
        knowledgeName: _knowledgeName,
        description: _knowledgeDescription,
        createdAt: DateTime.now(),
        userId: knowledge.userId,
      );

      final response = await updateKnowledgeBaseUsecase.call(
        knowledge.id,
        KnowledgeBaseCreationAndUpdateRequest(
          knowledgeName: updatedKnowledge.knowledgeName,
          description: updatedKnowledge.description,
        ),
      );

      if (response.data.isNotEmpty) {
        _setState(KnowledgeDetailState.success);
      } else {
        _setState(KnowledgeDetailState.failure);
      }
      return true;
    } catch (e) {
      print('Error updating knowledge: $e');
      _setState(KnowledgeDetailState.failure);
      return false;
    }
  }

  Future<bool> deleteKnowledge() async {
    if (_state == KnowledgeDetailState.loading) return false;

    try {
      _setState(KnowledgeDetailState.loading);

      final success = await deleteKnowledgeBaseUsecase.call(knowledge.id);

      if (success) {
        _setState(KnowledgeDetailState.success);
      } else {
        _setState(KnowledgeDetailState.failure);
      }
      return success;
    } catch (e) {
      debugPrint('Error deleting knowledge: $e');
      _setState(KnowledgeDetailState.failure);
      return false;
    }
  }

  Future<bool> loadKnowledgeDetails() async {
    if (_state == KnowledgeDetailState.loading) return false;

    try {
      _setState(KnowledgeDetailState.loading);

      _knowledgeName = knowledge.knowledgeName;
      _knowledgeDescription = knowledge.description;
      _url = knowledge.knowledgeName;

      _setState(KnowledgeDetailState.success);
    } catch (e) {
      print('Error loading knowledge details: $e');
      _setState(KnowledgeDetailState.failure);
      return false;
    }
    return true;
  }
}
