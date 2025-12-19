// Create Bot Request
class BotRequestModel {
  final String assistantName;
  final String instructions;
  final String description;

  BotRequestModel({
    required this.assistantName,
    required this.instructions,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'assistant_name': assistantName,
      'instructions': instructions,
      'description': description,
    };
  }
}

enum BotOrder { asc, desc }

// Get Bots Request
class GetBotsRequestModel {
  final String q;
  final BotOrder order;
  final String order_field;
  final int offset;
  final int limit;
  final bool? is_favorite;   // made optional
  final bool? is_published;  // made optional

  GetBotsRequestModel({
    this.q = '',
    this.order = BotOrder.desc,
    this.order_field = 'createdAt', // matches API docs
    this.offset = 0,
    this.limit = 10,
    this.is_favorite,
    this.is_published,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> params = {
      'q': q,
      'order': order == BotOrder.asc ? 'ASC' : 'DESC',
      'order_field': order_field,
      'offset': offset,
      'limit': limit,
    };
    if (is_favorite != null) params['is_favorite'] = is_favorite;
    if (is_published != null) params['is_published'] = is_published;
    return params;
  }
}
