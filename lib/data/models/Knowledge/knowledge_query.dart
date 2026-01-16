
class KnowledgeQuery {
  double? limit;
  double? offset;
  KnowledgeOrder? order;
  String? orderField;
  String? q;

  KnowledgeQuery({
    this.limit,
    this.offset,
    this.order,
    this.orderField,
    this.q,
  });

  factory KnowledgeQuery.fromJson(Map<String, dynamic> json) {
    return KnowledgeQuery(
      limit: (json['limit'] as num?)?.toDouble(),
      offset: (json['offset'] as num?)?.toDouble(),
      order: json['order'] != null
          ? KnowledgeOrder.values.firstWhere(
              (e) => e.toString() == 'Order.' + (json['order'] as String),
            )
          : null,
      orderField: json['orderField'] as String?,
      q: json['q'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (order != null) 'order': order.toString().split('.').last,
      if (orderField != null) 'orderField': orderField,
      if (q != null) 'q': q,
    };
  }
}

enum KnowledgeOrder { ASC, DESC }

class KnowledgeBaseCreationAndUpdateRequest {
  String? description;
  String knowledgeName;

  KnowledgeBaseCreationAndUpdateRequest({
    this.description,
    required this.knowledgeName,
  });

  factory KnowledgeBaseCreationAndUpdateRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return KnowledgeBaseCreationAndUpdateRequest(
      description: json['description'] as String?,
      knowledgeName: json['knowledgeName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (description != null) {
      data['description'] = description;
    }
    data['knowledgeName'] = knowledgeName;
    return data;
  }
}
