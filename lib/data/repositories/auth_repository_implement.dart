import 'package:khtn_ai_final_project/data/models/auth_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/auth_repository.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthResponse> signUp(SignUpRequest signUpRequest) async {
    return await remoteDataSource.signUp(signUpRequest);
  }

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await remoteDataSource.login(loginRequest);
  }

  @override
  Future<void> logout(String accessToken, String refreshToken) async {
    await remoteDataSource.logout(accessToken, refreshToken);
  }

  @override
  Future<RefreshTokenResponse> refreshToken() async {
    return await remoteDataSource.refreshToken();
  }
}
