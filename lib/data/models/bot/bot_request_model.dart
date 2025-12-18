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
  final String orderField;
  final int offset;
  final int limit;
  final bool is_favorite;
  final bool is_published;

  GetBotsRequestModel({
    this.q = '',
    this.order = BotOrder.desc,
    this.orderField = 'created_at',
    this.offset = 0,
    this.limit = 20,
    this.is_favorite = false,
    this.is_published = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'q': q,
      'order': order == BotOrder.asc ? 'ASC' : 'DESC',
      'order_field': orderField,
      'offset': offset,
      'limit': limit,
      'is_favorite': is_favorite,
      'is_published': is_published,
    };
  }
}
