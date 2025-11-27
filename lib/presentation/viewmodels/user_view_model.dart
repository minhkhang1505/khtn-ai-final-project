import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/user_models.dart';
import 'package:khtn_ai_final_project/domain/usecases/get_user_usecase.dart';

class UserViewModel extends ChangeNotifier {
  final GetUserUseCase getUserUseCase;

  UserViewModel({required this.getUserUseCase});
  UserResponse? _user;
  UserResponse? get user => _user;
  bool _isLoading = false;

  Future<bool> loadCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    final response = await getUserUseCase.call();
    _user = response;
    _isLoading = false;
    notifyListeners();

    return Future.value(true);
  }
}
