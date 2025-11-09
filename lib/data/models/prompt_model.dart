class PromptModel {
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

  PromptModel({
    required this.id,
    required this.title,
    this.description,
    required this.category,
    required this.content,
    required this.language,
    required this.isPublic,
    required this.userId,
    required this.userName,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.isFavorite,
  });
}
