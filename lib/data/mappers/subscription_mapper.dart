import 'package:khtn_ai_final_project/data/models/subscription/subscription_response.dart';
import 'package:khtn_ai_final_project/domain/entities/subscription_entity.dart';

class SubscriptionMapper {
  static SubscriptionEntity toDomain(SubscriptionResponse response) {
    return SubscriptionEntity(
      name: response.name,
      dailyTokens: response.dailyTokens,
      monthlyTokens: response.monthlyTokens,
      annuallyTokens: response.annuallyTokens,
    );
  }
}
