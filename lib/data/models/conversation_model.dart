import 'chat_model.dart';
import 'assistant_model.dart';

class ChatConversationModel {
  List<ChatMessageModel> messages = [];
  String id;

  ChatConversationModel({required this.id, required this.messages});

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) {
    var messagesFromJson = json['messages'] as List;
    List<ChatMessageModel> messageList = messagesFromJson.map((msg) => ChatMessageModel(
      content: msg['content'],
      files: List<String>.from(msg['files']),
      assistant: AssistantModel.fromJson(msg['assistant']),
    )).toList();

    return ChatConversationModel(
      id: json['id'],
      messages: messageList,
    );
  }

  factory ChatConversationModel.defaults() {
    return ChatConversationModel(
      id: '',
      messages: [],
    );
  }
}



// Request Model for GET conversations
class GetConversationsRequestModel {
  String cursor;
  int limit;
  String assistantId;
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

class Object {
  String title;
  String id;
  String createdAt;

  Object({
    required this.title,
    required this.id,
    required this.createdAt,
  });
}

// Response Model for GET conversations
class GetConversationsResponseModel {
  String cursor;
  bool hasMore;
  int limit;
  List <Object> objects;

  GetConversationsResponseModel({
    required this.cursor,
    required this.hasMore,
    required this.limit,
    required this.objects,
  });

  factory GetConversationsResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    var objectsFromJson = json['objects'] as List;
    List<Object> objectList = objectsFromJson.map((obj) => Object(
      title: obj['title'],
      id: obj['id'],
      createdAt: obj['createdAt'],
    )).toList();

    return GetConversationsResponseModel(
      cursor: json['cursor'],
      hasMore: json['hasMore'],
      limit: json['limit'],
      objects: objectList,
    );
  }
}

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

// Response Model for GET conversation history
class GetConversationHistoryResponseModel {
  bool hasMore;
  int limit;
  List<ChatMessageModel> items;

  GetConversationHistoryResponseModel({
    required this.hasMore,
    required this.limit,
    required this.items,
  });

  factory GetConversationHistoryResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    var itemsFromJson = json['items'] as List;
    List<ChatMessageModel> itemList = itemsFromJson.map((item) => ChatMessageModel(
      content: item['content'],
      files: List<String>.from(item['files']),
      assistant: AssistantModel.fromJson(item['assistant']),
    )).toList();

    return GetConversationHistoryResponseModel(
      hasMore: json['hasMore'],
      limit: json['limit'],
      items: itemList,
    );
  }
}