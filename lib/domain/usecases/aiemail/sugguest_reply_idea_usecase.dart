import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_request_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_response_entity.dart';
import 'package:khtn_ai_final_project/domain/repositories/ai_email_repository.dart';

class SugguestReplyIdeaUsecase {
  final AiEmailRepository aiEmailRepository;

  SugguestReplyIdeaUsecase({required this.aiEmailRepository});

  Future<SuggestReplyIdeaResponseEntity> call(
    SuggestReplyIdeaRequestEntity emailRequestEntity,
  ) {
    return aiEmailRepository.suggestReplyIdeas(emailRequestEntity);
  }
}
