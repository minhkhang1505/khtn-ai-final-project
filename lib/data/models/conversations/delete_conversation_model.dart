class DeleteConversationModel {
  final String conversationId;
  final String assistantId;
  final String assistantModel;
  DeleteConversationModel({required this.conversationId, required this.assistantId, required this.assistantModel});

  Map<String, dynamic> toJson() {
    return {
      'conversation_id': conversationId,
      'assistant_id': assistantId,
      'assistant_model': assistantModel,
    };
  }
}

class DeleteConversationResponseModel {
  final bool success;
  DeleteConversationResponseModel({required this.success});

  factory DeleteConversationResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteConversationResponseModel(
      success: json['success'] ?? false,
    );
  }
}