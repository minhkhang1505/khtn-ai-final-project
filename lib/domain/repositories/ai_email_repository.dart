import 'package:khtn_ai_final_project/domain/entities/email_request_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/email_response_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_request_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_response_entity.dart';

abstract class AiEmailRepository {
  Future<EmailResponseEntity> responseEmail(EmailRequestEntity request);
  Future<SuggestReplyIdeaResponseEntity> suggestReplyIdeas(
    SuggestReplyIdeaRequestEntity request,
  );
}
