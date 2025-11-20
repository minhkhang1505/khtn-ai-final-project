import 'package:khtn_ai_final_project/core/network/user_api_client.dart';
import 'package:khtn_ai_final_project/data/models/user_models.dart';

abstract class UserRemoteDataSource {
  Future<UserResponse> getCurrentUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final UserApiClient client;
  UserRemoteDataSourceImpl(this.client);
  @override
  Future<UserResponse> getCurrentUser() async {
    final response = await client.get('/auth/me', data: {});
    return UserResponse.fromJson(response.data);
  }
}
