import 'package:khtn_ai_final_project/data/datasources/remote/user_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/user_models.dart';
import 'package:khtn_ai_final_project/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserResponse> getCurrentUser() async {
    final response = await remoteDataSource.getCurrentUser();
    return response;
  }
}
