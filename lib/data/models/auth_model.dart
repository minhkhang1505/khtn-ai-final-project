// Request model for login
class LoginRequest {
  String email;
  String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

// Request model for sign-up
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

// Response model for sign-up, login, logout responses
class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final int statusCode;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.statusCode,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    return AuthResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      userId: json['user_id'],
      statusCode: statusCode,
    );
  }
}

// Response model for refresh token response
class RefreshTokenResponse {
  String accessToken;

  RefreshTokenResponse({required this.accessToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(accessToken: json['access_token']);
  }
}
