class ResponseEmailResponse {
    String email;
    int remainingUsage;

    ResponseEmailResponse({
        required this.email,
        required this.remainingUsage,
    });

    ResponseEmailResponse copyWith({
        String? email,
        int? remainingUsage,
    }) => 
        ResponseEmailResponse(
            email: email ?? this.email,
            remainingUsage: remainingUsage ?? this.remainingUsage,
        );
}