import 'package:khtn_ai_final_project/data/models/user_models.dart';
import 'package:khtn_ai_final_project/data/models/token_usage_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository userRepository;
  GetUserUseCase({required this.userRepository});

  Future<UserResponse> call() async {
    return await userRepository.getCurrentUser();
  }

  Future<TokenUsageModel> getTokenUsage() async {
    return await userRepository.getTokenUsage();
  }
}
