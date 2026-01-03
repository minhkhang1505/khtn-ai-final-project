class ResponseEmailResponse {
  String email;
  int remainingUsage;

  ResponseEmailResponse({required this.email, required this.remainingUsage});

  ResponseEmailResponse copyWith({String? email, int? remainingUsage}) =>
      ResponseEmailResponse(
        email: email ?? this.email,
        remainingUsage: remainingUsage ?? this.remainingUsage,
      );

  factory ResponseEmailResponse.fromJson(Map<String, dynamic> json) {
    return ResponseEmailResponse(
      email: json['email'] as String,
      remainingUsage: json['remainingUsage'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'remainingUsage': remainingUsage,
  };
}
