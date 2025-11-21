// Response model for prompts
class PrompResponse {
  bool hasNext;
  List<Item> items;
  int limit;
  int offset;
  int total;

  PrompResponse({
    required this.hasNext,
    required this.items,
    required this.limit,
    required this.offset,
    required this.total,
  });

  PrompResponse copyWith({
    bool? hasNext,
    List<Item>? items,
    int? limit,
    int? offset,
    int? total,
  }) => PrompResponse(
    hasNext: hasNext ?? this.hasNext,
    items: items ?? this.items,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    total: total ?? this.total,
  );
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
