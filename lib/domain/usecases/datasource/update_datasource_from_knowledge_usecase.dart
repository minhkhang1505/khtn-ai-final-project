import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';

@lazySingleton
class UpdateDataSourceFromKnowledgeUsecase {
  final KnowledgeBaseRepository repository;

  UpdateDataSourceFromKnowledgeUsecase({required this.repository});

  Future<bool> call(String knowledgeId, String datasourceId) {
    return repository.updateDataSourceFromKnowledge(knowledgeId, datasourceId);
  }
}
