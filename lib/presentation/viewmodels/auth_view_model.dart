import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/auth_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/login_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/logout_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/sign_up_usecase.dart';

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

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await loginUsecase.call(request);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        _error = null;
        debugPrint("Login successful for email: $email");
        return true;
      } else {
        _error = "Login failed with status code: $statusCode";
        debugPrint("Login error: $_error");
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

  Future<bool> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint("Starting sign-up for email: $email");
      final request = SignUpRequest(
        email: email,
        password: password,
        verificationCallbackUrl:
            "https://auth.dev.jarvis.cx/handler/email-verification?after_auth_return_to=%2Fauth%2Fsignin%3Fclient_id%3Djarvis_chat%26redirect%3Dhttps%253A%252F%252Fchat.dev.jarvis.cx%252Fauth%252Foauth%252Fsuccess",
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
