import 'package:khtn_ai_final_project/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  Future<void> call(String accessToken, String refreshToken) async {
    return await authRepository.logout(accessToken, refreshToken);
  }
}
