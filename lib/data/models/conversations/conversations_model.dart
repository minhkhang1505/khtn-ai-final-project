import 'conversation_model.dart';

// Request Model for GET conversations
class GetConversationsRequestModel {
  String? cursor;
  int limit;
  String? assistantId;
  String assistantModel = "dify";  // default model

  GetConversationsRequestModel({
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

// Response Model for GET conversations
class GetConversationsResponseModel {
  String cursor;
  bool hasMore;
  int limit;
  List <ConversationModel> items;

  GetConversationsResponseModel({
    required this.cursor,
    required this.hasMore,
    required this.limit,
    required this.items,
  });

  factory GetConversationsResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    final itemsJson = json['items'];

    final items = <ConversationModel>[];

    if (itemsJson is List) {
      for (final element in itemsJson) {
        if (element is Map<String, dynamic>) {
          items.add(ConversationModel.fromJson(element));
        } else {
          // debugPrint('Skipped invalid item in conversations: $element');
        }
      }
    }

    return GetConversationsResponseModel(
      cursor: json['cursor'] ?? '',
      hasMore: json['has_more'] ?? false,
      limit: json['limit'] ?? 0,
      items: items,
    );
  }
}