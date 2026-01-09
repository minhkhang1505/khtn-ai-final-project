import 'package:khtn_ai_final_project/data/models/email/suggest_reply_idea_response.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_response_entity.dart';

/// Mapper để chuyển đổi từ AiEmailReplyIdeasResponse (data layer)
/// sang SuggestReplyIdeaResponseEntity (domain layer)
extension AiEmailReplyIdeasResponseMapper on AiEmailReplyIdeasResponse {
  SuggestReplyIdeaResponseEntity toDomain() {
    return SuggestReplyIdeaResponseEntity(ideas: ideas);
  }
}

/// Mapper ngược từ Domain -> Data (nếu cần)
extension SuggestReplyIdeaResponseEntityMapper
    on SuggestReplyIdeaResponseEntity {
  AiEmailReplyIdeasResponse toData() {
    return AiEmailReplyIdeasResponse(ideas: ideas);
  }
}
