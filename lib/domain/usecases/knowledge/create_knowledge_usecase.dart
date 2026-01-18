import 'package:khtn_ai_final_project/data/models/Knowledge/knowledge_query.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateKnowledgeUsecase {
  final KnowledgeBaseRepository repository;

  CreateKnowledgeUsecase({required this.repository});
  Future<KnowledgeModel> call(KnowledgeBaseCreationAndUpdateRequest knowledge) async {
    final response = await repository.createKnowledge(knowledge);
    return response;
  }
}