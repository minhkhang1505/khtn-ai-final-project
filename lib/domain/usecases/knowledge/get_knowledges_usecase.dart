import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetKnowledgesUsecase {
  final KnowledgeBaseRepository repository;

  GetKnowledgesUsecase(this.repository);

  Future<KnowledgeBasePaggingResponse> call(KnowledgeQuery query) async {
    final response = await repository.getKnowledgeBases(query);
    return response;
  }
}
