import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';

abstract class KnowledgeBaseRepository {
  Future<KnowledgeBasePaggingResponse> getKnowledgeBases(KnowledgeQuery query);
}
