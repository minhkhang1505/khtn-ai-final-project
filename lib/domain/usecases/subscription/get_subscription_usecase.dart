import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/data/mappers/subscription_mapper.dart';
import 'package:khtn_ai_final_project/domain/entities/subscription_entity.dart';
import 'package:khtn_ai_final_project/domain/repositories/subscription_repository.dart';

@lazySingleton
class GetSubscriptionUsecase {
  final SubscriptionRepository repository;

  GetSubscriptionUsecase(this.repository);

  Future<SubscriptionEntity> call() async {
    final response = await repository.getSubscription();
    return SubscriptionMapper.toDomain(response);
  }
}
