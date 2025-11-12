class AuthFailures implements Exception {
  final String message;
  AuthFailures(this.message);
}

class InvalidCredentialsFailure extends AuthFailures {
  InvalidCredentialsFailure() : super("Invalid username or password.");
}


class NetworkFailure extends AuthFailures {
  NetworkFailure() : super("Network error occurred. Please try again.");
}