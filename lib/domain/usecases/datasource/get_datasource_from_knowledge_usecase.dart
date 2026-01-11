import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/data/models/datasource/data_source_response.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_entity.dart';
import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';

@lazySingleton
class GetDataSourceFromKnowledgeUsecase {
  final KnowledgeBaseRepository repository;

  GetDataSourceFromKnowledgeUsecase({required this.repository});

  Future<DataSourcePagingEntity> call(
    String knowledgeId,
    DataSourceQuery query,
  ) {
    return repository.getDataSourcesFromKnowledge(knowledgeId, query);
  }
}
