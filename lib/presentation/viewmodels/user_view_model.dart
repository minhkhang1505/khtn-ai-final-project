import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/user_models.dart';
import 'package:khtn_ai_final_project/domain/usecases/auth/get_user_usecase.dart';
import 'package:injectable/injectable.dart';

enum UserViewState { initial, loading, success, failure }

@injectable
class UserViewModel extends ChangeNotifier {
  final GetUserUseCase getUserUseCase;

  UserViewModel({required this.getUserUseCase});
  
  UserResponse? _user;
  UserResponse? get user => _user;

  UserViewState _state = UserViewState.initial;
  UserViewState get viewState => _state;

  void _setState(UserViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<bool> loadCurrentUser() async {
    _setState(UserViewState.loading);

    final response = await getUserUseCase.call();
    _user = response;
    _setState(UserViewState.success);

    return Future.value(true);
  }
}
