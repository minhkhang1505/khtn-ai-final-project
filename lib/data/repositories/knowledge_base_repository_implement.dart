import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/knowledge_base_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/mappers/datasource_mapper.dart';
import 'package:khtn_ai_final_project/data/models/Knowledge/knowledge_query.dart';
import 'package:khtn_ai_final_project/data/models/datasource/data_source_response.dart';
import 'package:khtn_ai_final_project/data/models/datasource/multi_file_response.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_entity.dart';
import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';

@LazySingleton(as: KnowledgeBaseRepository)
class KnowledgeBaseRepositoryImplement implements KnowledgeBaseRepository {
  final KnowledgeBaseRemoteDataSource remoteDataSource;

  KnowledgeBaseRepositoryImplement({required this.remoteDataSource});

  @override
  Future<KnowledgeBasePaggingResponse> getKnowledgeBases(KnowledgeQuery query) {
    return remoteDataSource.getKnowledgeBases(query);
  }

  @override
  Future<KnowledgeModel> createKnowledge(
    KnowledgeBaseCreationAndUpdateRequest knowledge,
  ) {
    return remoteDataSource.createKnowledgeBase(knowledge);
  }

  @override
  Future<KnowledgeModel> updateKnowledge(
    String id,
    KnowledgeBaseCreationAndUpdateRequest knowledge,
  ) {
    return remoteDataSource.updateKnowledgeBase(id, knowledge);
  }

  @override
  Future<bool> deleteKnowledge(String id) {
    final success = remoteDataSource.deleteKnowledgeBase(id);
    return success;
  }

  @override
  Future<UploadResponse> uploadMultipleFiles(List<PlatformFile> files) {
    return remoteDataSource.uploadMultipleFiles(files);
  }

  @override
  Future<DataSourcePagingEntity> getDataSourcesFromKnowledge(
    String knowledgeId,
    DataSourceQuery query,
  ) async {
    final response = await remoteDataSource.getDataSourcesFromKnowledge(
      knowledgeId,
      query,
    );
    return response.toDomain();
  }
}
