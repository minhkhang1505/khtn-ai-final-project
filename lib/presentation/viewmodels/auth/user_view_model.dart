import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/user_models.dart';
import 'package:khtn_ai_final_project/domain/entities/subscription_entity.dart';
import 'package:khtn_ai_final_project/domain/usecases/auth/get_user_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/subscription/get_subscription_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/subscription/get_subscription_used_usecase.dart';
import 'package:injectable/injectable.dart';

enum UserViewState { initial, loading, success, failure }

@injectable
class UserViewModel extends ChangeNotifier {
  final GetUserUseCase getUserUseCase;
  final GetSubscriptionUsecase getSubscriptionUsecase;
  final GetSubscriptionUsedUsecase getSubscriptionUsedUsecase;

  UserViewModel({
    required this.getUserUseCase,
    required this.getSubscriptionUsecase,
    required this.getSubscriptionUsedUsecase,
  });

  UserResponse? _user;
  UserResponse? get user => _user;

  SubscriptionEntity? _subscription;
  SubscriptionEntity? get subscription => _subscription;

  UserViewState _state = UserViewState.initial;
  UserViewState get viewState => _state;

  UserViewState _subscriptionState = UserViewState.initial;
  UserViewState get subscriptionState => _subscriptionState;

  UserViewState _subscribeState = UserViewState.initial;
  UserViewState get subscribeState => _subscribeState;

  void _setState(UserViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void _setSubscriptionState(UserViewState viewState) {
    _subscriptionState = viewState;
    notifyListeners();
  }

  void _setSubscribeState(UserViewState viewState) {
    _subscribeState = viewState;
    notifyListeners();
  }

  Future<bool> loadCurrentUser() async {
    _setState(UserViewState.loading);

    final response = await getUserUseCase.call();
    _user = response;
    _setState(UserViewState.success);

    return Future.value(true);
  }

  Future<bool> getSubscriptionUsege() async {
    _setSubscriptionState(UserViewState.loading);

    try {
      final subscription = await getSubscriptionUsecase.call();
      _subscription = subscription;
      _setSubscriptionState(UserViewState.success);
      return Future.value(true);
    } catch (e) {
      _setSubscriptionState(UserViewState.failure);
      return Future.value(false);
    }
  }

  Future<bool> subscribe() async {
    _setSubscribeState(UserViewState.loading);

    try {
      final success = await getSubscriptionUsedUsecase.call();
      _setSubscribeState(UserViewState.success);
      return Future.value(success);
    } catch (e) {
      _setSubscribeState(UserViewState.failure);
      return Future.value(false);
    }
  }
}
