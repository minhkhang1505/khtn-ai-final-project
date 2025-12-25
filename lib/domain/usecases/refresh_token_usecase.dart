import 'package:khtn_ai_final_project/data/models/auth_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/auth_repository.dart';

class RefreshTokenUsecase {
  final AuthRepository authRepository;
  RefreshTokenUsecase({required this.authRepository});

  Future<RefreshTokenResponse> call() async {
    return await authRepository.refreshToken();
  }
}
