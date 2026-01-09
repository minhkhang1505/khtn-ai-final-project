import 'package:khtn_ai_final_project/data/models/email/response_email_request.dart';
import 'package:khtn_ai_final_project/domain/entities/email_request_entity.dart';

/// Mapper để chuyển đổi từ ResponseEmailRequest (data layer)
/// sang EmailRequestEntity (domain layer)
extension ResponseEmailRequestMapper on ResponseEmailRequest {
  EmailRequestEntity toDomain() {
    return EmailRequestEntity(
      action: action,
      assistant: assistant?.toDomain(),
      email: email,
      mainIdea: mainIdea,
      metadata: metadata.toDomain(),
    );
  }
}

/// Mapper cho AssistantDto
extension AssistantDtoMapper on AssistantDto {
  AssistantEntity toDomain() {
    return AssistantEntity(id: id?.toDomain(), model: model.toDomain());
  }
}

/// Mapper cho Id enum
extension IdMapper on Id {
  AssistantModelId toDomain() {
    switch (this) {
      case Id.CLAUDE_3_HAIKU_20240307:
        return AssistantModelId.claude3Haiku20240307;
      case Id.CLAUDE_3_SONNET_20240229:
        return AssistantModelId.claude3Sonnet20240229;
      case Id.GEMINI_15_FLASH_LATEST:
        return AssistantModelId.gemini15FlashLatest;
      case Id.GEMINI_15_PRO_LATEST:
        return AssistantModelId.gemini15ProLatest;
      case Id.GPT_4_O:
        return AssistantModelId.gpt4O;
      case Id.GPT_4_O_MINI:
        return AssistantModelId.gpt4OMini;
    }
  }
}

/// Mapper cho Model enum
extension ModelMapper on Model {
  AssistantModel toDomain() {
    switch (this) {
      case Model.DIFY:
        return AssistantModel.dify;
    }
  }
}

/// Mapper cho AiEmailMetadata
extension AiEmailMetadataMapper on AiEmailMetadata {
  EmailMetadataEntity toDomain() {
    return EmailMetadataEntity(
      context: context.map((c) => c.toDomain()).toList(),
      language: language,
      receiver: receiver,
      sender: sender,
      style: style.toDomain(),
      subject: subject,
    );
  }
}

/// Mapper cho EmailContent
extension EmailContentMapper on EmailContent {
  EmailContentEntity toDomain() {
    return EmailContentEntity(
      content: content,
      receiver: receiver,
      sender: sender,
      subject: subject,
    );
  }
}

/// Mapper cho AiEmailStyleDto
extension AiEmailStyleDtoMapper on AiEmailStyleDto {
  EmailStyleEntity toDomain() {
    return EmailStyleEntity(formality: formality, length: length, tone: tone);
  }
}

/// Mapper ngược từ Domain -> Data (nếu cần)
extension EmailRequestEntityMapper on EmailRequestEntity {
  ResponseEmailRequest toData() {
    return ResponseEmailRequest(
      action: action,
      assistant: assistant?.toData(),
      email: email,
      mainIdea: mainIdea,
      metadata: metadata.toData(),
    );
  }
}

extension AssistantEntityMapper on AssistantEntity {
  AssistantDto toData() {
    return AssistantDto(id: id?.toData(), model: model.toData());
  }
}

extension AssistantModelIdMapper on AssistantModelId {
  Id toData() {
    switch (this) {
      case AssistantModelId.claude3Haiku20240307:
        return Id.CLAUDE_3_HAIKU_20240307;
      case AssistantModelId.claude3Sonnet20240229:
        return Id.CLAUDE_3_SONNET_20240229;
      case AssistantModelId.gemini15FlashLatest:
        return Id.GEMINI_15_FLASH_LATEST;
      case AssistantModelId.gemini15ProLatest:
        return Id.GEMINI_15_PRO_LATEST;
      case AssistantModelId.gpt4O:
        return Id.GPT_4_O;
      case AssistantModelId.gpt4OMini:
        return Id.GPT_4_O_MINI;
    }
  }
}

extension AssistantModelMapper on AssistantModel {
  Model toData() {
    switch (this) {
      case AssistantModel.dify:
        return Model.DIFY;
    }
  }
}

extension EmailMetadataEntityMapper on EmailMetadataEntity {
  AiEmailMetadata toData() {
    return AiEmailMetadata(
      context: context.map((c) => c.toData()).toList(),
      language: language,
      receiver: receiver,
      sender: sender,
      style: style.toData(),
      subject: subject,
    );
  }
}

extension EmailContentEntityMapper on EmailContentEntity {
  EmailContent toData() {
    return EmailContent(
      content: content,
      receiver: receiver,
      sender: sender,
      subject: subject,
    );
  }
}

extension EmailStyleEntityMapper on EmailStyleEntity {
  AiEmailStyleDto toData() {
    return AiEmailStyleDto(formality: formality, length: length, tone: tone);
  }
}
