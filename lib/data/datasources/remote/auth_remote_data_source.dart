import 'package:khtn_ai_final_project/core/network/auth_api_client.dart';
import 'package:khtn_ai_final_project/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> signUp(SignUpRequest registerRequest);
  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<void> logout(String accessToken, String refreshToken);
  Future<RefreshTokenResponse> refreshToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient client;

  AuthRemoteDataSourceImpl(this.client);

  //for sign-up
  @override
  Future<AuthResponse> signUp(SignUpRequest registerRequest) async {
    final response = await client.post(
      '/auth/password/sign-up',
      data: registerRequest.toJson(),
    );
    return AuthResponse.fromJson(response.data, response.statusCode ?? 0);
  }

  //for login
  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    final response = await client.post(
      '/auth/password/sign-in',
      data: loginRequest.toJson(),
    );
    return AuthResponse.fromJson(response.data, response.statusCode ?? 0);
  }

  // for logout
  @override
  Future<void> logout(String accessToken, String refreshToken) async {
    await client.delete(
      '/auth/sessions/current',
      token: accessToken,
      refreshToken: refreshToken,
    );
  }

  // for refresh token
  @override
  Future<RefreshTokenResponse> refreshToken() async {
    final response = await client.post(
      '/auth/sessions/current/refresh',
      data: {},
    );
    return RefreshTokenResponse.fromJson(response.data);
  }
}
