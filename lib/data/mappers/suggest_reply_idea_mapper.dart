import 'package:khtn_ai_final_project/data/models/email/suggest_reply_idea_request.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_request_entity.dart';

/// Mapper để chuyển đổi từ SuggestReplyIdeaRequest (data layer)
/// sang SuggestReplyIdeaRequestEntity (domain layer)
extension SuggestReplyIdeaRequestMapper on SuggestReplyIdeaRequest {
  SuggestReplyIdeaRequestEntity toDomain() {
    return SuggestReplyIdeaRequestEntity(
      action: action,
      assistant: assistant?.toDomain(),
      email: email,
      metadata: metadata.toDomain(),
    );
  }
}

/// Mapper cho AssistantDto (Suggest Reply)
extension SuggestAssistantDtoMapper on AssistantDto {
  SuggestAssistantEntity toDomain() {
    return SuggestAssistantEntity(id: id?.toDomain(), model: model.toDomain());
  }
}

/// Mapper cho Id enum (Suggest Reply)
extension SuggestIdMapper on Id {
  SuggestAssistantModelId toDomain() {
    switch (this) {
      case Id.CLAUDE_3_HAIKU_20240307:
        return SuggestAssistantModelId.claude3Haiku20240307;
      case Id.CLAUDE_3_SONNET_20240229:
        return SuggestAssistantModelId.claude3Sonnet20240229;
      case Id.GEMINI_15_FLASH_LATEST:
        return SuggestAssistantModelId.gemini15FlashLatest;
      case Id.GEMINI_15_PRO_LATEST:
        return SuggestAssistantModelId.gemini15ProLatest;
      case Id.GPT_4_O:
        return SuggestAssistantModelId.gpt4O;
      case Id.GPT_4_O_MINI:
        return SuggestAssistantModelId.gpt4OMini;
    }
  }
}

/// Mapper cho Model enum (Suggest Reply)
extension SuggestModelMapper on Model {
  SuggestAssistantModel toDomain() {
    switch (this) {
      case Model.DIFY:
        return SuggestAssistantModel.dify;
    }
  }
}

/// Mapper cho AiEmailReplyIdeasMetadata
extension AiEmailReplyIdeasMetadataMapper on AiEmailReplyIdeasMetadata {
  SuggestReplyMetadataEntity toDomain() {
    return SuggestReplyMetadataEntity(
      context: context.map((c) => c.toDomain()).toList(),
      language: language,
      receiver: receiver,
      sender: sender,
      subject: subject,
    );
  }
}

/// Mapper cho EmailContent (Suggest Reply)
extension SuggestEmailContentMapper on EmailContent {
  SuggestEmailContentEntity toDomain() {
    return SuggestEmailContentEntity(
      content: content,
      receiver: receiver,
      sender: sender,
      subject: subject,
    );
  }
}

/// Mapper ngược từ Domain -> Data (nếu cần)
extension SuggestReplyIdeaRequestEntityMapper on SuggestReplyIdeaRequestEntity {
  SuggestReplyIdeaRequest toData() {
    return SuggestReplyIdeaRequest(
      action: action,
      assistant: assistant?.toData(),
      email: email,
      metadata: metadata.toData(),
    );
  }
}

extension SuggestAssistantEntityMapper on SuggestAssistantEntity {
  AssistantDto toData() {
    return AssistantDto(id: id?.toData(), model: model.toData());
  }
}

extension SuggestAssistantModelIdMapper on SuggestAssistantModelId {
  Id toData() {
    switch (this) {
      case SuggestAssistantModelId.claude3Haiku20240307:
        return Id.CLAUDE_3_HAIKU_20240307;
      case SuggestAssistantModelId.claude3Sonnet20240229:
        return Id.CLAUDE_3_SONNET_20240229;
      case SuggestAssistantModelId.gemini15FlashLatest:
        return Id.GEMINI_15_FLASH_LATEST;
      case SuggestAssistantModelId.gemini15ProLatest:
        return Id.GEMINI_15_PRO_LATEST;
      case SuggestAssistantModelId.gpt4O:
        return Id.GPT_4_O;
      case SuggestAssistantModelId.gpt4OMini:
        return Id.GPT_4_O_MINI;
    }
  }
}

extension SuggestAssistantModelMapper on SuggestAssistantModel {
  Model toData() {
    switch (this) {
      case SuggestAssistantModel.dify:
        return Model.DIFY;
    }
  }
}

extension SuggestReplyMetadataEntityMapper on SuggestReplyMetadataEntity {
  AiEmailReplyIdeasMetadata toData() {
    return AiEmailReplyIdeasMetadata(
      context: context.map((c) => c.toData()).toList(),
      language: language,
      receiver: receiver,
      sender: sender,
      subject: subject,
    );
  }
}

extension SuggestEmailContentEntityMapper on SuggestEmailContentEntity {
  EmailContent toData() {
    return EmailContent(
      content: content,
      receiver: receiver,
      sender: sender,
      subject: subject,
    );
  }
}
