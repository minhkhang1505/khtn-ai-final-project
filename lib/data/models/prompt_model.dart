// Response model for prompts
class PromptResponse {
  bool hasNext;
  List<Item> items;
  int limit;
  int offset;
  int total;

  PromptResponse({
    required this.hasNext,
    required this.items,
    required this.limit,
    required this.offset,
    required this.total,
  });

  PromptResponse copyWith({
    bool? hasNext,
    List<Item>? items,
    int? limit,
    int? offset,
    int? total,
  }) => PromptResponse(
    hasNext: hasNext ?? this.hasNext,
    items: items ?? this.items,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    total: total ?? this.total,
  );

  factory PromptResponse.fromJson(Map<String, dynamic> json) {
    return PromptResponse(
      hasNext: json['hasNext'] as bool,
      items: (json['items'] as List<dynamic>)
          .map(
            (item) => Item(
              id: item['id'] as String,
              category: item['category'] as String,
              content: item['content'] as String,
              createdAt: item['createdAt'] as String,
              description: item['description'] as String?,
              isFavorite: item['isFavorite'] as bool,
              isPublic: item['isPublic'] as bool,
              language: item['language'] as String,
              title: item['title'] as String,
              updatedAt: item['updatedAt'] as String,
              userId: item['userId'] as String,
              userName: item['userName'] as String,
            ),
          )
          .toList(),
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
    );
  }
}

class Item {
  String id;
  String category;
  String content;
  String createdAt;
  String? description;
  bool isFavorite;
  bool isPublic;
  String language;
  String title;
  String updatedAt;
  String userId;
  String userName;

  Item({
    required this.id,
    required this.category,
    required this.content,
    required this.createdAt,
    required this.description,
    required this.isFavorite,
    required this.isPublic,
    required this.language,
    required this.title,
    required this.updatedAt,
    required this.userId,
    required this.userName,
  });

  Item copyWith({
    String? id,
    String? category,
    String? content,
    String? createdAt,
    String? description,
    bool? isFavorite,
    bool? isPublic,
    String? language,
    String? title,
    String? updatedAt,
    String? userId,
    String? userName,
  }) => Item(
    id: id ?? this.id,
    category: category ?? this.category,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    description: description ?? this.description,
    isFavorite: isFavorite ?? this.isFavorite,
    isPublic: isPublic ?? this.isPublic,
    language: language ?? this.language,
    title: title ?? this.title,
    updatedAt: updatedAt ?? this.updatedAt,
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
  );
}

// Request model for prompts
class PromptRequest {
  Category? category;
  bool? isFavorite;
  bool? isPublic;

  ///limit
  double? limit;

  ///offset
  double? offset;

  ///search by keyword
  String? query;

  PromptRequest({
    this.category,
    this.isFavorite,
    this.isPublic,
    this.limit,
    this.offset,
    this.query,
  });

  PromptRequest copyWith({
    Category? category,
    bool? isFavorite,
    bool? isPublic,
    double? limit,
    double? offset,
    String? query,
  }) => PromptRequest(
    category: category ?? this.category,
    isFavorite: isFavorite ?? this.isFavorite,
    isPublic: isPublic ?? this.isPublic,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    query: query ?? this.query,
  );

  Map<String, dynamic> toJson() {
    return {
      if (category != null) 'category': category.toString().split('.').last,
      if (isFavorite != null) 'isFavorite': isFavorite,
      if (isPublic != null) 'isPublic': isPublic,
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (query != null) 'query': query,
    };
  }
}

enum Category {
  BUSINESS,
  CAREER,
  CHATBOT,
  CODING,
  EDUCATION,
  FUN,
  MARKETING,
  OTHER,
  PRODUCTIVITY,
  SEO,
  WRITING,
}



///CreatePromptDto
class CreatePromptRequest {
    String category;
    String content;
    String description;
    bool isPublic;
    String language;
    String title;

    CreatePromptRequest({
        required this.category,
        required this.content,
        required this.description,
        required this.isPublic,
        required this.language,
        required this.title,
    });

    CreatePromptRequest copyWith({
        String? category,
        String? content,
        String? description,
        bool? isPublic,
        String? language,
        String? title,
    }) => 
        CreatePromptRequest(
            category: category ?? this.category,
            content: content ?? this.content,
            description: description ?? this.description,
            isPublic: isPublic ?? this.isPublic,
            language: language ?? this.language,
            title: title ?? this.title,
        );
}