///AiEmailSuggestedReplyIdeasDto
class SuggestReplyIdeaRequest {
  String action;
  AssistantDto? assistant;
  String email;
  AiEmailReplyIdeasMetadata metadata;

  SuggestReplyIdeaRequest({
    required this.action,
    this.assistant,
    required this.email,
    required this.metadata,
  });

  SuggestReplyIdeaRequest copyWith({
    String? action,
    AssistantDto? assistant,
    String? email,
    AiEmailReplyIdeasMetadata? metadata,
  }) => SuggestReplyIdeaRequest(
    action: action ?? this.action,
    assistant: assistant ?? this.assistant,
    email: email ?? this.email,
    metadata: metadata ?? this.metadata,
  );

  factory SuggestReplyIdeaRequest.fromJson(Map<String, dynamic> json) {
    return SuggestReplyIdeaRequest(
      action: json['action'] as String,
      assistant: json['assistant'] != null
          ? AssistantDto.fromJson(json['assistant'] as Map<String, dynamic>)
          : null,
      email: json['email'] as String,
      metadata: AiEmailReplyIdeasMetadata.fromJson(
        json['metadata'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'action': action,
    'assistant': assistant?.toJson(),
    'email': email,
    'metadata': metadata.toJson(),
  };
}

///AssistantDto
class AssistantDto {
  Id? id;
  Model model;

  AssistantDto({this.id, required this.model});

  AssistantDto copyWith({Id? id, Model? model}) =>
      AssistantDto(id: id ?? this.id, model: model ?? this.model);

  factory AssistantDto.fromJson(Map<String, dynamic> json) {
    return AssistantDto(
      id: json['id'] != null ? _idFromJson(json['id'] as String) : null,
      model: _modelFromJson(json['model'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id != null ? _idToJson(id!) : null,
    'model': _modelToJson(model),
  };

  static Id _idFromJson(String value) {
    switch (value) {
      case 'claude-3-haiku-20240307':
        return Id.CLAUDE_3_HAIKU_20240307;
      case 'claude-3-sonnet-20240229':
        return Id.CLAUDE_3_SONNET_20240229;
      case 'gemini-1.5-flash-latest':
        return Id.GEMINI_15_FLASH_LATEST;
      case 'gemini-1.5-pro-latest':
        return Id.GEMINI_15_PRO_LATEST;
      case 'gpt-4o':
        return Id.GPT_4_O;
      case 'gpt-4o-mini':
        return Id.GPT_4_O_MINI;
      default:
        return Id.values.firstWhere(
          (e) => e.toString().split('.').last == value,
          orElse: () => Id.CLAUDE_3_HAIKU_20240307,
        );
    }
  }

  static String _idToJson(Id value) {
    switch (value) {
      case Id.CLAUDE_3_HAIKU_20240307:
        return 'claude-3-haiku-20240307';
      case Id.CLAUDE_3_SONNET_20240229:
        return 'claude-3-sonnet-20240229';
      case Id.GEMINI_15_FLASH_LATEST:
        return 'gemini-1.5-flash-latest';
      case Id.GEMINI_15_PRO_LATEST:
        return 'gemini-1.5-pro-latest';
      case Id.GPT_4_O:
        return 'gpt-4o';
      case Id.GPT_4_O_MINI:
        return 'gpt-4o-mini';
    }
  }

  static Model _modelFromJson(String value) {
    switch (value) {
      case 'dify':
      case 'DIFY':
        return Model.DIFY;
      default:
        return Model.values.firstWhere(
          (e) => e.toString().split('.').last == value,
          orElse: () => Model.DIFY,
        );
    }
  }

  static String _modelToJson(Model value) {
    switch (value) {
      case Model.DIFY:
        return 'dify';
    }
  }
}

enum Id {
  CLAUDE_3_HAIKU_20240307,
  CLAUDE_3_SONNET_20240229,
  GEMINI_15_FLASH_LATEST,
  GEMINI_15_PRO_LATEST,
  GPT_4_O,
  GPT_4_O_MINI,
}

enum Model { DIFY }

///AiEmailReplyIdeasMetadata
class AiEmailReplyIdeasMetadata {
  List<EmailContent> context;
  String language;
  String receiver;
  String sender;
  String subject;

  AiEmailReplyIdeasMetadata({
    required this.context,
    required this.language,
    required this.receiver,
    required this.sender,
    required this.subject,
  });

  AiEmailReplyIdeasMetadata copyWith({
    List<EmailContent>? context,
    String? language,
    String? receiver,
    String? sender,
    String? subject,
  }) => AiEmailReplyIdeasMetadata(
    context: context ?? this.context,
    language: language ?? this.language,
    receiver: receiver ?? this.receiver,
    sender: sender ?? this.sender,
    subject: subject ?? this.subject,
  );

  factory AiEmailReplyIdeasMetadata.fromJson(Map<String, dynamic> json) {
    return AiEmailReplyIdeasMetadata(
      context: (json['context'] as List<dynamic>)
          .map((e) => EmailContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      language: json['language'] as String,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      subject: json['subject'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'context': context.map((e) => e.toJson()).toList(),
    'language': language,
    'receiver': receiver,
    'sender': sender,
    'subject': subject,
  };
}

///EmailContent
class EmailContent {
  String content;
  String receiver;
  String sender;
  String subject;

  EmailContent({
    required this.content,
    required this.receiver,
    required this.sender,
    required this.subject,
  });

  EmailContent copyWith({
    String? content,
    String? receiver,
    String? sender,
    String? subject,
  }) => EmailContent(
    content: content ?? this.content,
    receiver: receiver ?? this.receiver,
    sender: sender ?? this.sender,
    subject: subject ?? this.subject,
  );

  factory EmailContent.fromJson(Map<String, dynamic> json) {
    return EmailContent(
      content: json['content'] as String,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      subject: json['subject'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'content': content,
    'receiver': receiver,
    'sender': sender,
    'subject': subject,
  };
}
