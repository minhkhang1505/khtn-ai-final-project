import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';

class DeleteKnowledgeBaseUsecase {
  final KnowledgeBaseRepository repository;

  DeleteKnowledgeBaseUsecase({required this.repository});

  Future<bool> call(String id) async {
    return await repository.deleteKnowledge(id);
  }
}
