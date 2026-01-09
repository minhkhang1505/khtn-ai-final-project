class AiEmailReplyIdeasResponse {
  final List<String> ideas;

  AiEmailReplyIdeasResponse({
    required this.ideas,
  });

  factory AiEmailReplyIdeasResponse.fromJson(Map<String, dynamic> json) {
    return AiEmailReplyIdeasResponse(
      ideas: List<String>.from(json['ideas'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ideas': ideas,
    };
  }
}
