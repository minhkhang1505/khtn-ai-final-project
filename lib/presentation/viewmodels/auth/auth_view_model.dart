import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:khtn_ai_final_project/data/models/auth_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/auth/login_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/auth/logout_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/auth/sign_up_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthViewModel extends ChangeNotifier {
  // ViewModel implementation will go here
  final SignUpUseCase signUpUseCase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;

  AuthViewModel({
    required this.signUpUseCase,
    required this.loginUsecase,
    required this.logoutUsecase,
  });

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? fullNameError;

  void clearErrors() {
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
    fullNameError = null;
    _error = null;
    notifyListeners();
  }

  void setError(String message) {
    _error = message;
    notifyListeners();
  }

  bool validate(
    String email,
    String password,
    String? confirmPassword,
    String? fullName,
  ) {
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
    fullNameError = null;
    _error = null;

    if (email.isEmpty) {
      _error = "Email cannot be empty";
      emailError = "Email cannot be empty";
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      emailError = "Invalid email format";
    }

    if (password.isEmpty) {
      _error = "Password cannot be empty";
      passwordError = "Password cannot be empty";
    } else if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~.,;:]).{8,}$',
    ).hasMatch(password)) {
      passwordError =
          "Password must be at least 8 characters long and include uppercase, lowercase, number, and special character.";
    }

    if (confirmPassword != null) {
      if (confirmPassword.isEmpty) {
        confirmPasswordError = "Confirm Password cannot be empty";
      } else if (confirmPassword != password) {
        confirmPasswordError = "Passwords do not match";
      }
    }

    if (fullName != null) {
      if (fullName.isEmpty) {
        fullNameError = "Full name cannot be empty";
      }
    }

    notifyListeners();
    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        fullNameError == null;
  }

  Future<bool> login(String email, String password) async {
    clearErrors();
    _isLoading = true;
    notifyListeners();

    if (!validate(email, password, null, null)) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await loginUsecase.call(request);

      final statusCode = response.statusCode;
      debugPrintThrottled("Login response status code: $statusCode");

      if (statusCode == 200) {
        _error = null;
        debugPrint("Login successful for email: $email");
        return true;
      } else {
        _error = "Login failed with status code: $statusCode";
        debugPrint("Login error: $_error");
        return false;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        _error = "Invalid email or password";
      } else {
        _error = "Login failed: ${e.message}";
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp(
    String email,
    String password,
    String? confirmPassword,
    String? fullName,
  ) async {
    clearErrors();
    _isLoading = true;
    notifyListeners();

    if (!validate(email, password, confirmPassword, fullName)) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      debugPrint("Starting sign-up for email: $email");
      final request = SignUpRequest(
        email: email,
        password: password,
        verificationCallbackUrl:
            "https://auth.jarvis.cx/handler/email-verification?after_auth_return_to=%2Fauth%2Fsignin%3Fclient_id%3Djarvis_chat%26redirect%3Dhttps%253A%252F%252Fchat.jarvis.cx%252Fauth%252Foauth%252Fsuccess",
      );

      final response = await signUpUseCase.call(request);
      final statusCode = response.statusCode;

      if (statusCode == 200) {
        _error = null;
        debugPrint("Sign-up successful for email: $email");
        return true;
      } else if (statusCode == 409) {
        _error = "Email already exists";
        _isLoading = false;
        debugPrint("Sign-up error: $_error");
        return false;
      } else {
        _error = "Sign-up failed with status code: $statusCode";
        _isLoading = false;
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await logoutUsecase.call();
      _error = null;
      debugPrint("Logout successful");
      return true;
    } catch (e) {
      _error = e.toString();
      debugPrint("Logout error: $_error");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
