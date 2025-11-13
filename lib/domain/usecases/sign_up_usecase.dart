import 'package:khtn_ai_final_project/data/models/auth_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;
  SignUpUseCase({required this.repository});

  Future<AuthResponse> call(SignUpRequest signUpRequest) async {
    return await repository.signUp(signUpRequest);
  }
}
