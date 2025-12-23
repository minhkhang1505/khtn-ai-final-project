import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:khtn_ai_final_project/domain/entities/knowledge_entity.dart';

extension KnowledgeMapper on KnowledgeResDto {
  KnowledgeEntity toEntity() {
    return KnowledgeEntity(
      knowledgeName: knowledgeName,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
      updatedBy: updatedBy,
      userId: 'unknown', id: 'unknown',
    );
  }
}

extension KnowledgeListMapper on List<KnowledgeResDto> {
  List<KnowledgeEntity> toEntityList() {
    return map((item) => item.toEntity()).toList();
  }
}
