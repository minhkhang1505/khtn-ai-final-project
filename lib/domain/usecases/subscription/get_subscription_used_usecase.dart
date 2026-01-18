import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/domain/repositories/subscription_repository.dart';

@lazySingleton
class GetSubscriptionUsedUsecase {
  final SubscriptionRepository repository;

  GetSubscriptionUsedUsecase(this.repository);

  Future<bool> call() async {
    return await repository.subscribe();
  }
}
