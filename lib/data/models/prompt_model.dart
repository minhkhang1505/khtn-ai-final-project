// Response model for prompts
class PromptPaggingResponse {
  bool hasNext;
  List<PromptItem> items;
  int limit;
  int offset;
  int total;

  PromptPaggingResponse({
    required this.hasNext,
    required this.items,
    required this.limit,
    required this.offset,
    required this.total,
  });

  PromptPaggingResponse copyWith({
    bool? hasNext,
    List<PromptItem>? items,
    int? limit,
    int? offset,
    int? total,
  }) => PromptPaggingResponse(
    hasNext: hasNext ?? this.hasNext,
    items: items ?? this.items,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    total: total ?? this.total,
  );

  factory PromptPaggingResponse.fromJson(Map<String, dynamic> json) {
    return PromptPaggingResponse(
      hasNext: json['hasNext'] as bool? ?? false,
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (item) => PromptItem(
                  id: item['id'] as String? ?? '',
                  category: item['category'] as String? ?? '',
                  content: item['content'] as String? ?? '',
                  createdAt: item['createdAt'] as String? ?? '',
                  description: item['description'] as String?,
                  isFavorite: item['isFavorite'] as bool? ?? false,
                  isPublic: item['isPublic'] as bool? ?? false,
                  language: item['language'] as String? ?? '',
                  title: item['title'] as String? ?? '',
                  updatedAt: item['updatedAt'] as String? ?? '',
                  userId: item['userId'] as String? ?? '',
                  userName: item['userName'] as String? ?? '',
                ),
              )
              .toList() ??
          [],
      limit: json['limit'] as int? ?? 0,
      offset: json['offset'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );
  }
}

class PromptItem {
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

  PromptItem({
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

  PromptItem copyWith({
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
  }) => PromptItem(
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
class PromptCreationAndUpdateRequest {
  String category;
  String content;
  String description;
  bool isPublic;
  String language;
  String title;

  PromptCreationAndUpdateRequest({
    required this.category,
    required this.content,
    required this.description,
    required this.isPublic,
    required this.language,
    required this.title,
  });

  PromptCreationAndUpdateRequest copyWith({
    String? category,
    String? content,
    String? description,
    bool? isPublic,
    String? language,
    String? title,
  }) => PromptCreationAndUpdateRequest(
    category: category ?? this.category,
    content: content ?? this.content,
    description: description ?? this.description,
    isPublic: isPublic ?? this.isPublic,
    language: language ?? this.language,
    title: title ?? this.title,
  );

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'content': content,
      'description': description,
      'isPublic': isPublic,
      'language': language,
      'title': title,
    };
  }
}
