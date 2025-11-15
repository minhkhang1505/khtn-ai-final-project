import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:khtn_ai_final_project/data/models/auth_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/auth_repository.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthResponse> signUp(SignUpRequest signUpRequest) async {
    final response = await remoteDataSource.signUp(signUpRequest);

    if (response.statusCode == 200) {
      await localDataSource.saveTokens(
        access: response.accessToken,
        refresh: response.refreshToken,
      );
    }
    return response;
  }

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    final response = await remoteDataSource.login(loginRequest);

    if (response.statusCode == 200) {
      await localDataSource.saveTokens(
        access: response.accessToken,
        refresh: response.refreshToken,
      );
    } 

    return response;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.clearTokens();
  }

  @override
  Future<RefreshTokenResponse> refreshToken() async {
    final response = await remoteDataSource.refreshToken();

    if (response.accessToken.isNotEmpty) {
      await localDataSource.saveTokens(
        access: response.accessToken,
      );
    }
    return response;
  }
}
