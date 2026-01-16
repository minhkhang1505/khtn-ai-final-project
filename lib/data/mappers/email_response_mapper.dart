import 'package:khtn_ai_final_project/data/models/email/response_email_response.dart';
import 'package:khtn_ai_final_project/domain/entities/email_response_entity.dart';

/// Mapper để chuyển đổi từ ResponseEmailResponse (data layer)
/// sang EmailResponseEntity (domain layer)
extension ResponseEmailResponseMapper on ResponseEmailResponse {
  EmailResponseEntity toDomain() {
    return EmailResponseEntity(email: email, remainingUsage: remainingUsage);
  }
}

/// Mapper ngược từ Domain -> Data (nếu cần)
extension EmailResponseEntityMapper on EmailResponseEntity {
  ResponseEmailResponse toData() {
    return ResponseEmailResponse(email: email, remainingUsage: remainingUsage);
  }
}
