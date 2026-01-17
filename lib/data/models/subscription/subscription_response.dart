class SubscriptionResponse {
    int annuallyTokens;
    int dailyTokens;
    int monthlyTokens;
    String name;

    SubscriptionResponse({
        required this.annuallyTokens,
        required this.dailyTokens,
        required this.monthlyTokens,
        required this.name,
    });

    SubscriptionResponse copyWith({
        int? annuallyTokens,
        int? dailyTokens,
        int? monthlyTokens,
        String? name,
    }) => 
        SubscriptionResponse(
            annuallyTokens: annuallyTokens ?? this.annuallyTokens,
            dailyTokens: dailyTokens ?? this.dailyTokens,
            monthlyTokens: monthlyTokens ?? this.monthlyTokens,
            name: name ?? this.name,
        );

    factory SubscriptionResponse.fromJson(Map<String, dynamic> json) => SubscriptionResponse(
        annuallyTokens: json['annuallyTokens'] ?? 0,
        dailyTokens: json['dailyTokens'] ?? 0,
        monthlyTokens: json['monthlyTokens'] ?? 0,
        name: json['name'] ?? '',
    );
}