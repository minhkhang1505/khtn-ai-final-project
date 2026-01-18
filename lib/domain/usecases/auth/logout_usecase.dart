import 'package:khtn_ai_final_project/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  Future<void> call() async {
    final result = await authRepository.logout();
    return result;
  }
}
