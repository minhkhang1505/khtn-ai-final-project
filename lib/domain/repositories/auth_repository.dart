import 'package:khtn_ai_final_project/data/models/auth_model.dart';

abstract class AuthRepository {
  Future<AuthResponse> signUp(SignUpRequest signUpRequest);
}
