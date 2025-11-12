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
}
