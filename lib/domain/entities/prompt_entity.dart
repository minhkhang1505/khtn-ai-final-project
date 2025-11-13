class PromptEntity {
  final String id;
  final String title;
  final String? description;
  final String category;
  final String content;
  final String language;
  final bool isPublic;
  final String userId;
  final String userName;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;
  final bool isFavorite;

  PromptEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.content,
    this.description,
    required this.isPublic,
    required this.language,
    required this.title,
    required this.userId,
    required this.userName,
    required this.isFavorite,
    required this.createdBy,
    required this.updatedBy,
  });

  factory PromptEntity.fromJson(Map<String, dynamic> json) {
    return PromptEntity(
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      category: json['category'] ?? '',
      content: json['content'] ?? '',
      description: json['description'],
      isPublic: json['isPublic'] ?? false,
      language: json['language'] ?? '',
      title: json['title'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      createdBy: json['createdBy'] ?? '',
      updatedBy: json['updatedBy'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'category': category,
      'content': content,
      'description': description,
      'isPublic': isPublic,
      'language': language,
      'title': title,
      'userId': userId,
      'userName': userName,
      'isFavorite': isFavorite,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };  
  }

  PromptEntity copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? category,
    String? content,
    String? description,
    bool? isPublic,
    String? language,
    String? title,
    String? userId,
    String? userName,
    bool? isFavorite,
  }) {
    return PromptEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      content: content ?? this.content,
      description: description ?? this.description,
      isPublic: isPublic ?? this.isPublic,
      language: language ?? this.language,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      isFavorite: isFavorite ?? this.isFavorite,
      createdBy: createdBy,
      updatedBy: updatedBy,
    );
  }
}
