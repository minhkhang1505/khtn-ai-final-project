///AiEmailResponseDto
class ResponseEmailRequest {
  String action;
  AssistantDto? assistant;
  String email;
  String mainIdea;
  AiEmailMetadata metadata;

  ResponseEmailRequest({
    required this.action,
    this.assistant,
    required this.email,
    required this.mainIdea,
    required this.metadata,
  });

  ResponseEmailRequest copyWith({
    String? action,
    AssistantDto? assistant,
    String? email,
    String? mainIdea,
    AiEmailMetadata? metadata,
  }) => ResponseEmailRequest(
    action: action ?? this.action,
    assistant: assistant ?? this.assistant,
    email: email ?? this.email,
    mainIdea: mainIdea ?? this.mainIdea,
    metadata: metadata ?? this.metadata,
  );

  factory ResponseEmailRequest.fromJson(Map<String, dynamic> json) {
    return ResponseEmailRequest(
      action: json['action'] as String,
      assistant: json['assistant'] != null
          ? AssistantDto.fromJson(json['assistant'] as Map<String, dynamic>)
          : null,
      email: json['email'] as String,
      mainIdea: json['mainIdea'] as String,
      metadata: AiEmailMetadata.fromJson(
        json['metadata'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'action': action,
    'assistant': assistant?.toJson(),
    'email': email,
    'mainIdea': mainIdea,
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
    // Map from API format to enum
    const map = {
      'claude-3-haiku-20240307': Id.CLAUDE_3_HAIKU_20240307,
      'claude-3-sonnet-20240229': Id.CLAUDE_3_SONNET_20240229,
      'gemini-1.5-flash-latest': Id.GEMINI_15_FLASH_LATEST,
      'gemini-1.5-pro-latest': Id.GEMINI_15_PRO_LATEST,
      'gpt-4o': Id.GPT_4_O,
      'gpt-4o-mini': Id.GPT_4_O_MINI,
    };
    return map[value] ?? Id.CLAUDE_3_HAIKU_20240307;
  }

  static String _idToJson(Id value) {
    // Map from enum to API format
    const map = {
      Id.CLAUDE_3_HAIKU_20240307: 'claude-3-haiku-20240307',
      Id.CLAUDE_3_SONNET_20240229: 'claude-3-sonnet-20240229',
      Id.GEMINI_15_FLASH_LATEST: 'gemini-1.5-flash-latest',
      Id.GEMINI_15_PRO_LATEST: 'gemini-1.5-pro-latest',
      Id.GPT_4_O: 'gpt-4o',
      Id.GPT_4_O_MINI: 'gpt-4o-mini',
    };
    return map[value] ?? 'claude-3-haiku-20240307';
  }

  static Model _modelFromJson(String value) {
    if (value.toLowerCase() == 'dify') {
      return Model.DIFY;
    }
    return Model.DIFY;
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

///AiEmailMetadata
class AiEmailMetadata {
  List<EmailContent> context;
  String language;
  String receiver;
  String sender;
  AiEmailStyleDto style;
  String subject;

  AiEmailMetadata({
    required this.context,
    required this.language,
    required this.receiver,
    required this.sender,
    required this.style,
    required this.subject,
  });

  AiEmailMetadata copyWith({
    List<EmailContent>? context,
    String? language,
    String? receiver,
    String? sender,
    AiEmailStyleDto? style,
    String? subject,
  }) => AiEmailMetadata(
    context: context ?? this.context,
    language: language ?? this.language,
    receiver: receiver ?? this.receiver,
    sender: sender ?? this.sender,
    style: style ?? this.style,
    subject: subject ?? this.subject,
  );

  factory AiEmailMetadata.fromJson(Map<String, dynamic> json) {
    return AiEmailMetadata(
      context: (json['context'] as List<dynamic>)
          .map((e) => EmailContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      language: json['language'] as String,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      style: AiEmailStyleDto.fromJson(json['style'] as Map<String, dynamic>),
      subject: json['subject'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'context': context.map((e) => e.toJson()).toList(),
    'language': language,
    'receiver': receiver,
    'sender': sender,
    'style': style.toJson(),
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

///AiEmailStyleDto
class AiEmailStyleDto {
  String formality;
  String length;
  String tone;

  AiEmailStyleDto({
    required this.formality,
    required this.length,
    required this.tone,
  });

  AiEmailStyleDto copyWith({String? formality, String? length, String? tone}) =>
      AiEmailStyleDto(
        formality: formality ?? this.formality,
        length: length ?? this.length,
        tone: tone ?? this.tone,
      );

  factory AiEmailStyleDto.fromJson(Map<String, dynamic> json) {
    return AiEmailStyleDto(
      formality: json['formality'] as String,
      length: json['length'] as String,
      tone: json['tone'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'formality': formality,
    'length': length,
    'tone': tone,
  };
}
