/// Entity đại diện cho Suggest Reply Idea Request trong domain layer
class SuggestReplyIdeaRequestEntity {
  final String action;
  final SuggestAssistantEntity? assistant;
  final String email;
  final SuggestReplyMetadataEntity metadata;

  const SuggestReplyIdeaRequestEntity({
    required this.action,
    this.assistant,
    required this.email,
    required this.metadata,
  });
}

/// Entity cho Assistant (Suggest Reply)
class SuggestAssistantEntity {
  final SuggestAssistantModelId? id;
  final SuggestAssistantModel model;

  const SuggestAssistantEntity({this.id, required this.model});
}

/// Enum cho Assistant Model ID (Suggest Reply)
enum SuggestAssistantModelId {
  claude3Haiku20240307,
  claude3Sonnet20240229,
  gemini15FlashLatest,
  gemini15ProLatest,
  gpt4O,
  gpt4OMini,
}

/// Enum cho Assistant Model (Suggest Reply)
enum SuggestAssistantModel { dify }

/// Entity cho Reply Ideas Metadata
class SuggestReplyMetadataEntity {
  final List<SuggestEmailContentEntity> context;
  final String language;
  final String receiver;
  final String sender;
  final String subject;

  const SuggestReplyMetadataEntity({
    required this.context,
    required this.language,
    required this.receiver,
    required this.sender,
    required this.subject,
  });

  bool get hasContext => context.isNotEmpty;
}

/// Entity cho Email Content (Suggest Reply)
class SuggestEmailContentEntity {
  final String content;
  final String receiver;
  final String sender;
  final String subject;

  const SuggestEmailContentEntity({
    required this.content,
    required this.receiver,
    required this.sender,
    required this.subject,
  });

  bool get isValid =>
      content.isNotEmpty &&
      receiver.isNotEmpty &&
      sender.isNotEmpty &&
      subject.isNotEmpty;
}
