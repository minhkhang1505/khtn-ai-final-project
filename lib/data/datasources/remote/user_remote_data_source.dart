import 'package:khtn_ai_final_project/core/network/jarvis_api_client.dart';
import 'package:khtn_ai_final_project/data/models/user_models.dart';
import 'package:khtn_ai_final_project/data/models/token_usage_model.dart';
import 'package:injectable/injectable.dart';

abstract class UserRemoteDataSource {
  Future<UserResponse> getCurrentUser();
  Future<TokenUsageModel> getTokenUsage();
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final JarvisApiClient client;
  UserRemoteDataSourceImpl(this.client);
  @override
  Future<UserResponse> getCurrentUser() async {
    final response = await client.get('/auth/me', data: {});
    return UserResponse.fromJson(response.data);
  }

  @override
  Future<TokenUsageModel> getTokenUsage() async {
    final response = await client.get('/tokens/usage');
    return TokenUsageModel.fromJson(response.data);
  }
}
