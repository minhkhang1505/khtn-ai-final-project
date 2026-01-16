// Request Model for GET conversation history
class GetConversationHistoryRequestModel {
  String conversationId;
  String? assistantId;
  String assistantModel;

  GetConversationHistoryRequestModel({
    required this.conversationId,
    this.assistantId,
    this.assistantModel = "dify",
  });

  Map<String, dynamic> toJson() {
    return {
      'assistantId': assistantId,
      'assistantModel': assistantModel,
    };
  }
}

// Sub-model for inputs field
class InputsModel {
  String assistant;
  List<String> toolIds;

  InputsModel({
    required this.assistant,
    required this.toolIds,
  });

  factory InputsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return InputsModel(assistant: '', toolIds: []);
    }

    return InputsModel(
      assistant: json['assistant'] ?? '',
      toolIds: (json['tool_ids'] is List)
          ? List<String>.from(json['tool_ids'])
          : <String>[],
    );
  }
}

// Response Model for GET conversation history
class MessageAndResponseModel {
  String answer;
  String createdAt;
  String query;
  InputsModel inputs;

  MessageAndResponseModel({
    required this.answer,
    required this.createdAt,
    required this.query,
    required this.inputs,
  });

  factory MessageAndResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageAndResponseModel(
      answer: json['answer'] ?? '',
      createdAt: json['createdAt'] ?? '',
      query: json['query'] ?? '',
      inputs: InputsModel.fromJson(json['inputs']),
    );
  }
}

// Response Model for GET conversation history
class GetConversationHistoryResponseModel {
  bool hasMore;
  List<MessageAndResponseModel> items;

  GetConversationHistoryResponseModel({
    required this.hasMore,
    required this.items,
  });

  factory GetConversationHistoryResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    final rawItems = json['items'];

    final List<MessageAndResponseModel> items = [];

    if (rawItems is List) {
      for (final element in rawItems) {
        if (element is Map<String, dynamic>) {
          items.add(MessageAndResponseModel.fromJson(element));
        }
      }
    }

    return GetConversationHistoryResponseModel(
      hasMore: json['has_more'] ?? false,
      items: items,
    );
  }
}
