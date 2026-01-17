class SubscriptionEntity {
  final String name;
  final int dailyTokens;
  final int monthlyTokens;
  final int annuallyTokens;

  SubscriptionEntity({
    required this.name,
    required this.dailyTokens,
    required this.monthlyTokens,
    required this.annuallyTokens,
  });
}
