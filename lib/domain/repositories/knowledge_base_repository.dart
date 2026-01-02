import 'package:file_picker/file_picker.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/datasource/multi_file_response.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';

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

  // Future<bool> importDataSourceIntoKnowledgeBase() {}
}
