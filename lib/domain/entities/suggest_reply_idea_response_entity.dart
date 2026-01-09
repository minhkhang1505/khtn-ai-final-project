/// Entity đại diện cho Suggest Reply Idea Response trong domain layer
class SuggestReplyIdeaResponseEntity {
  final List<String> ideas;

  const SuggestReplyIdeaResponseEntity({required this.ideas});

  bool get hasIdeas => ideas.isNotEmpty;
  int get ideaCount => ideas.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuggestReplyIdeaResponseEntity &&
          runtimeType == other.runtimeType &&
          ideas.toString() == other.ideas.toString();

  @override
  int get hashCode => ideas.hashCode;
}
