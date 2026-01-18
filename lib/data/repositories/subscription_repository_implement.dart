import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/subscription_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/subscription/subscription_response.dart';
import 'package:khtn_ai_final_project/domain/repositories/subscription_repository.dart';

@LazySingleton(as: SubscriptionRepository)
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepositoryImpl(this.remoteDataSource);

  @override
  Future<SubscriptionResponse> getSubscription() async {
    final response = await remoteDataSource.getSubscription();
    return response;
  }

  @override
  Future<bool> subscribe() async {
    final response = await remoteDataSource.subscribe();
    return response;
  }
}
