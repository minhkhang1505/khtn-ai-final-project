// Request Model for GET conversation history
class GetConversationHistoryRequestModel {
  String conversationId;
  String cursor;
  int limit;
  String assistantId;
  String assistantModel = "dify";  // default model

  GetConversationHistoryRequestModel({
    required this.conversationId,
    required this.cursor,
    required this.limit,
    required this.assistantId,
    required this.assistantModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'cursor': cursor,
      'limit': limit,
      'assistantId': assistantId,
      'assistantModel': assistantModel,
    };
  }
}

class InputsModel{
  String assistant;
  List<String> toolIds;

  InputsModel({
    required this.assistant,
    required this.toolIds,
  });

}
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
}

// Response Model for GET conversation history
class GetConversationHistoryResponseModel {
  bool hasMore;
  int limit;
  List<MessageAndResponseModel> items;

  GetConversationHistoryResponseModel({
    required this.hasMore,
    required this.limit,
    required this.items,
  });

  factory GetConversationHistoryResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    var itemsFromJson = json['items'] as List;
    List<MessageAndResponseModel> itemList = itemsFromJson.map((item) => MessageAndResponseModel(
      answer: item['answer'],
      createdAt: item['createdAt'],
      query: (item['query']),
      inputs: InputsModel(
        assistant: item['inputs']['assistant'],
        toolIds: List<String>.from(item['inputs']['toolIds']),
      ),
    )).toList();

    return GetConversationHistoryResponseModel(
      hasMore: json['hasMore'],
      limit: json['limit'],
      items: itemList,
    );
  }
}