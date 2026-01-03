import 'package:khtn_ai_final_project/core/network/jarvis_api_client.dart';
import 'package:khtn_ai_final_project/data/models/email/response_email_request.dart';
import 'package:khtn_ai_final_project/data/models/email/response_email_response.dart';
import 'package:khtn_ai_final_project/data/models/email/suggest_reply_idea_request.dart';
import 'package:khtn_ai_final_project/data/models/email/suggest_reply_idea_response.dart';

abstract class EmailRemoteDataSource {
  Future<ResponseEmailResponse> requestEmail(ResponseEmailRequest request);

  Future<AiEmailReplyIdeasResponse> requestAiEmailReplyIdeas(
    SuggestReplyIdeaRequest request,
  );
}

class EmailRemoteDataSourceImpl implements EmailRemoteDataSource {
  final JarvisApiClient client;

  EmailRemoteDataSourceImpl(this.client);

  @override
  Future<ResponseEmailResponse> requestEmail(
    ResponseEmailRequest request,
  ) async {
    final response = await client.post('/ai-email', data: request.toJson());
    return ResponseEmailResponse.fromJson(response.data);
  }

  @override
  Future<AiEmailReplyIdeasResponse> requestAiEmailReplyIdeas(
    SuggestReplyIdeaRequest request,
  ) async {
    final response = await client.post(
      '/ai-email/reply-ideas',
      data: request.toJson(),
    );
    return AiEmailReplyIdeasResponse.fromJson(response.data);
  }
}
