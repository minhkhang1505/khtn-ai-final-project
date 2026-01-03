/// Entity đại diện cho Email Request trong domain layer
class EmailRequestEntity {
  final String action;
  final AssistantEntity? assistant;
  final String email;
  final String mainIdea;
  final EmailMetadataEntity metadata;

  const EmailRequestEntity({
    required this.action,
    this.assistant,
    required this.email,
    required this.mainIdea,
    required this.metadata,
  });
}

/// Entity cho Assistant
class AssistantEntity {
  final AssistantModelId? id;
  final AssistantModel model;

  const AssistantEntity({this.id, required this.model});
}

/// Enum cho Assistant Model ID
enum AssistantModelId {
  claude3Haiku20240307,
  claude3Sonnet20240229,
  gemini15FlashLatest,
  gemini15ProLatest,
  gpt4O,
  gpt4OMini,
}

/// Enum cho Assistant Model
enum AssistantModel { dify }

/// Entity cho Email Metadata
class EmailMetadataEntity {
  final List<EmailContentEntity> context;
  final String language;
  final String receiver;
  final String sender;
  final EmailStyleEntity style;
  final String subject;

  const EmailMetadataEntity({
    required this.context,
    required this.language,
    required this.receiver,
    required this.sender,
    required this.style,
    required this.subject,
  });

  bool get hasContext => context.isNotEmpty;
}

/// Entity cho Email Content
class EmailContentEntity {
  final String content;
  final String receiver;
  final String sender;
  final String subject;

  const EmailContentEntity({
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

/// Entity cho Email Style
class EmailStyleEntity {
  final String formality;
  final String length;
  final String tone;

  const EmailStyleEntity({
    required this.formality,
    required this.length,
    required this.tone,
  });
}
