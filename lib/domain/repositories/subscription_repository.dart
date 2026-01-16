
import 'package:khtn_ai_final_project/data/models/subscription/subscription_response.dart';

abstract class SubscriptionRepository {
	Future<SubscriptionResponse> getSubscription();
	Future<bool> subscribe();
}
