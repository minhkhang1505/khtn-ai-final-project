import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/data/models/datasource/data_source_request.dart';
import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';

@lazySingleton
class AddDatasourceFromWebsiteToKnowledgeUsecase {
  final KnowledgeBaseRepository repository;

  AddDatasourceFromWebsiteToKnowledgeUsecase({required this.repository});

  Future<bool> call(String knowledgeId, DataSourceRequest request) async {
    return await repository.addDataSourceBaseFromWebSiteToKnowledgeBase(
      knowledgeId,
      request,
    );
  }
}
