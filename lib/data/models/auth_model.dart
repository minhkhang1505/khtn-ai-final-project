class LoginRequest {
  String email;
  String password;

  LoginRequest({required this.email, required this.password});
}

class SignUpRequest {
  String email;
  String password;
  String verificationCallbackUrl;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.verificationCallbackUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'verification_callback_url': verificationCallbackUrl,
    };
  }
}

class AuthResponse {
  String accessToken;
  String refreshToken;
  String userId;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      userId: json['user_id'],
    );
  }
}

class RefreshTokenResponse {
  String accessToken;

  RefreshTokenResponse({required this.accessToken});
}
