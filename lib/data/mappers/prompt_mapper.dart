import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';

extension PromptItemMapper on PromptModel {
  PromptEntity toEntity() {
    return PromptEntity(
      id: id.isNotEmpty ? id : 'unknown',
      title: title.isNotEmpty ? title : 'Untitled',
      description: description,
      category: category.isNotEmpty ? category : 'OTHER',
      content: content,
      language: language.isNotEmpty ? language : 'en',
      isPublic: isPublic,
      userId: userId.isNotEmpty ? userId : 'unknown',
      userName: userName.isNotEmpty ? userName : 'Unknown User',
      createdAt: createdAt.isNotEmpty
          ? createdAt
          : DateTime.now().toIso8601String(),
      updatedAt: updatedAt.isNotEmpty
          ? updatedAt
          : DateTime.now().toIso8601String(),
      createdBy: userId.isNotEmpty ? userId : 'unknown',
      updatedBy: userId.isNotEmpty ? userId : 'unknown',
      isFavorite: isFavorite,
    );
  }
}

extension PromptItemListMapper on List<PromptModel> {
  List<PromptEntity> toEntityList() {
    return map((item) => item.toEntity()).toList();
  }
}
