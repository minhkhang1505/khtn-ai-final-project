class BotModel {
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String udpatedby;
  final String id;
  final String assistantName;
  final String openAiAssistantId;
  final String instructions;
  final String description;
  final String openAiThreadIdPlay;

  BotModel({
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.udpatedby,
    required this.id,
    required this.assistantName,
    required this.openAiAssistantId,
    required this.instructions,
    required this.description,
    required this.openAiThreadIdPlay,
  });

  factory BotModel.fromJson(Map<String, dynamic> json) {
    return BotModel(
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      udpatedby: json['udpatedby'],
      id: json['id'],
      assistantName: json['assistant_name'],
      openAiAssistantId: json['open_ai_assistant_id'],
      instructions: json['instructions'],
      description: json['description'],
      openAiThreadIdPlay: json['open_ai_thread_id_play'],
    );
  }
}