import 'package:khtn_ai_final_project/data/datasources/remote/email_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/mappers/email_mapper.dart';
import 'package:khtn_ai_final_project/data/mappers/email_response_mapper.dart';
import 'package:khtn_ai_final_project/data/mappers/suggest_reply_idea_mapper.dart';
import 'package:khtn_ai_final_project/data/mappers/suggest_reply_idea_response_mapper.dart';
import 'package:khtn_ai_final_project/domain/entities/email_request_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/email_response_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_request_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_response_entity.dart';
import 'package:khtn_ai_final_project/domain/repositories/ai_email_repository.dart';

class AiEmailRepositoryImplement implements AiEmailRepository {
  final EmailRemoteDataSource remoteDataSource;

  AiEmailRepositoryImplement({required this.remoteDataSource});

  @override
  Future<EmailResponseEntity> responseEmail(EmailRequestEntity request) async {
    final response = await remoteDataSource.requestEmail(request.toData());
    return response.toDomain();
  }

  @override
  Future<SuggestReplyIdeaResponseEntity> suggestReplyIdeas(
    SuggestReplyIdeaRequestEntity request,
  ) async {
    final response = await remoteDataSource.requestAiEmailReplyIdeas(
      request.toData(),
    );
    return response.toDomain();
  }
}
