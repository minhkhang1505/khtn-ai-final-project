import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/core/network/jarvis_api_client.dart';
import 'package:khtn_ai_final_project/data/models/subscription/subscription_response.dart';

abstract class SubscriptionRemoteDataSource {
  Future<SubscriptionResponse> getSubscription();
  Future<bool> subscribe();
}

@LazySingleton(as: SubscriptionRemoteDataSource)
class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final JarvisApiClient _apiClient;

  SubscriptionRemoteDataSourceImpl(this._apiClient);

  @override
  Future<SubscriptionResponse> getSubscription() async {
    // GET /subscriptions/me
    final response = await _apiClient.get('subscriptions/me');
    return SubscriptionResponse.fromJson(response.data);
  }

  @override
  Future<bool> subscribe() async {
    // GET /subscriptions/subscribe
    final response = await _apiClient.get('subscriptions/subscribe');
    return response.statusCode == 200;
  }
}
