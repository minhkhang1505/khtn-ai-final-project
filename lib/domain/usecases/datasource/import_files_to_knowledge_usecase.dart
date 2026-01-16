import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/data/models/datasource/data_source_request.dart';
import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';

@lazySingleton
class ImportFilesToKnowledgeUsecase {
  final KnowledgeBaseRepository repository;

  ImportFilesToKnowledgeUsecase({required this.repository});

  Future<bool> call(String knowledgeBaseId, DataSourceRequest request) async {
    return await repository.addDataSourceBaseFromFileToKnowledgeBase(
      knowledgeBaseId,
      request,
    );
  }
}
