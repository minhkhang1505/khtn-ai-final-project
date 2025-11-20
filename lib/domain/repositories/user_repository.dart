import 'package:khtn_ai_final_project/data/models/user_models.dart';

abstract class UserRepository {
  Future<UserResponse> getCurrentUser();
}