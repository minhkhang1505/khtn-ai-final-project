import 'package:khtn_ai_final_project/domain/entities/email_request_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/email_response_entity.dart';
import 'package:khtn_ai_final_project/domain/repositories/ai_email_repository.dart';

class AiEmailUsecase {
  final AiEmailRepository repository;

  AiEmailUsecase({required this.repository});

  Future<EmailResponseEntity> call(EmailRequestEntity request) {
    return repository.responseEmail(request);
  }
}