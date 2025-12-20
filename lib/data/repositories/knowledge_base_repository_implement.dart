import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';

class KnowledgeBaseRepositoryImplement implements KnowledgeBaseRepository {
  final KnowledgeBaseRemoteDataSource remoteDataSource;

  KnowledgeBaseRepositoryImplement({required this.remoteDataSource});

  @override
  Future<KnowledgeBasePaggingResponse> getKnowledgeBases(KnowledgeQuery query) {
    return remoteDataSource.getKnowledgeBases(query);
  }

  @override
  Future<KnowledgeModel> createKnowledge(KnowledgeBaseCreationAndUpdateRequest knowledge) {
    return remoteDataSource.createKnowledgeBase(knowledge);
  }
}
