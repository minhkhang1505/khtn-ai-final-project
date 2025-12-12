import 'package:khtn_ai_final_project/data/models/user_models.dart';
import 'package:khtn_ai_final_project/data/models/token_usage_model.dart';

abstract class UserRepository {
  Future<UserResponse> getCurrentUser();
  Future<TokenUsageModel> getTokenUsage();
}