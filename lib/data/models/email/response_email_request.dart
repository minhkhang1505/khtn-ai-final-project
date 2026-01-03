
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
    }) => 
        ResponseEmailRequest(
            action: action ?? this.action,
            assistant: assistant ?? this.assistant,
            email: email ?? this.email,
            mainIdea: mainIdea ?? this.mainIdea,
            metadata: metadata ?? this.metadata,
        );
}


///AssistantDto
class AssistantDto {
    Id? id;
    Model model;

    AssistantDto({
        this.id,
        required this.model,
    });

    AssistantDto copyWith({
        Id? id,
        Model? model,
    }) => 
        AssistantDto(
            id: id ?? this.id,
            model: model ?? this.model,
        );
}

enum Id {
    CLAUDE_3_HAIKU_20240307,
    CLAUDE_3_SONNET_20240229,
    GEMINI_15_FLASH_LATEST,
    GEMINI_15_PRO_LATEST,
    GPT_4_O,
    GPT_4_O_MINI
}

enum Model {
    DIFY
}


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
    }) => 
        AiEmailMetadata(
            context: context ?? this.context,
            language: language ?? this.language,
            receiver: receiver ?? this.receiver,
            sender: sender ?? this.sender,
            style: style ?? this.style,
            subject: subject ?? this.subject,
        );
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
    }) => 
        EmailContent(
            content: content ?? this.content,
            receiver: receiver ?? this.receiver,
            sender: sender ?? this.sender,
            subject: subject ?? this.subject,
        );
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

    AiEmailStyleDto copyWith({
        String? formality,
        String? length,
        String? tone,
    }) => 
        AiEmailStyleDto(
            formality: formality ?? this.formality,
            length: length ?? this.length,
            tone: tone ?? this.tone,
        );
}