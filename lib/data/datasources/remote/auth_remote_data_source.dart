import 'package:khtn_ai_final_project/core/network/api_client.dart';
import 'package:khtn_ai_final_project/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> signUp(SignUpRequest registerRequest);
  // Future<AuthResponse> login(LoginRequest loginRequest);
  // Future<void> logout();
  // Future<RefreshTokenResponse> refreshToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<AuthResponse> signUp(SignUpRequest registerRequest) async {
    final response = await client.post(
      '/auth/password/sign-up',
      data: registerRequest.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }
}
