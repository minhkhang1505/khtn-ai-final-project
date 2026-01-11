import 'package:file_picker/file_picker.dart';
import 'package:khtn_ai_final_project/data/models/Knowledge/knowledge_query.dart';
import 'package:khtn_ai_final_project/data/models/datasource/data_source_response.dart';
import 'package:khtn_ai_final_project/data/models/datasource/multi_file_response.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_entity.dart';

abstract class KnowledgeBaseRepository {
  Future<KnowledgeBasePaggingResponse> getKnowledgeBases(KnowledgeQuery query);
  Future<KnowledgeModel> createKnowledge(
    KnowledgeBaseCreationAndUpdateRequest knowledge,
  );
  Future<KnowledgeModel> updateKnowledge(
    String id,
    KnowledgeBaseCreationAndUpdateRequest knowledge,
  );
  Future<bool> deleteKnowledge(String id);

  Future<UploadResponse> uploadMultipleFiles(List<PlatformFile> files);

  Future<DataSourcePagingEntity> getDataSourcesFromKnowledge(
    String knowledgeId,
    DataSourceQuery query,
  );

  Future<bool> deleteDataSourceFromKnowledge(
    String knowledgeId,
    String datasourceId,
  );

  Future<bool> updateDataSourceFromKnowledge(
    String knowledgeId,
    String datasourceId,
  );
}
