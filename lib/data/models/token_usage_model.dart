class TokenUsageModel {
  int availableTokens;
  int totalTokens;
  bool unlimited;
  String date;

  TokenUsageModel({
    required this.availableTokens,
    required this.totalTokens,
    required this.unlimited,
    required this.date,
  });

  factory TokenUsageModel.fromJson(Map<String, dynamic> json) {
    return TokenUsageModel(
      availableTokens: json['available_tokens'],
      totalTokens: json['total_tokens'],
      unlimited: json['unlimited'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available_tokens': availableTokens,
      'total_tokens': totalTokens,
      'unlimited': unlimited,
      'date': date,
    };
  }
}