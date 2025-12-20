// Create Bot Request
class BotRequestModel {
  final String assistantName;
  final String instructions;
  final String description;
  final String? model;

  BotRequestModel({
    required this.assistantName,
    required this.instructions,
    required this.description,
    this.model,
  });

  Map<String, dynamic> toJson() {
    return {
      'assistantName': assistantName,
      'instructions': instructions,
      'description': description,
      if (model != null) 'model': model,
    };
  }
}

enum BotOrder { asc, desc }

// Get Bots Request
class GetBotsRequestModel {
  String q;
  BotOrder? order;
  String? orderField;
  int offset;
  int limit;
  bool? isFavorite;   // optional filter
  bool? isPublished;  // optional filter

  GetBotsRequestModel({
    this.q = '',
    this.order,
    this.orderField,
    this.offset = 0,
    this.limit = 10,
    this.isFavorite,
    this.isPublished,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> params = {
      'q': q,
      'offset': offset,
      'limit': limit,
    };
    if (order != null) params['order'] = order == BotOrder.asc ? 'ASC' : 'DESC';
    if (orderField != null && orderField!.isNotEmpty) params['order_field'] = orderField;
    if (isFavorite != null) params['is_favorite'] = isFavorite;
    if (isPublished != null) params['is_published'] = isPublished;
    return params;
  }
}
