class Prompt {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String category;
  final String content;
  final String? description;
  final bool isPublic;
  final String language;
  final String title;
  final String userId;
  final String userName;
  final bool isFavorite;

  Prompt({
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
  });

  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
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
    };
  }

  Prompt copyWith({
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
    return Prompt(
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
    );
  }
}
