import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/email_request_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/email_response_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_request_entity.dart';
import 'package:khtn_ai_final_project/domain/entities/suggest_reply_idea_response_entity.dart';
import 'package:khtn_ai_final_project/domain/usecases/aiemail/ai_email_usecase.dart';
import 'package:khtn_ai_final_project/domain/usecases/aiemail/sugguest_reply_idea_usecase.dart';
import 'package:injectable/injectable.dart';

enum AiEmailState { initial, loading, success, failure }

@injectable
class AiEmailViewmodel extends ChangeNotifier {
  final AiEmailUsecase aiEmailUsecase;
  final SugguestReplyIdeaUsecase sugguestReplyIdeaUsecase;

  AiEmailViewmodel({
    required this.aiEmailUsecase,
    required this.sugguestReplyIdeaUsecase,
  });

  AiEmailState _state = AiEmailState.initial;
  AiEmailState get state => _state;

  EmailResponseEntity? _response;
  EmailResponseEntity? get response => _response;

  SuggestReplyIdeaResponseEntity? _suggestReplyIdeaResponse;
  SuggestReplyIdeaResponseEntity? get suggestReplyIdeaResponse =>
      _suggestReplyIdeaResponse;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setState(AiEmailState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Call AI Email API to generate email response
  /// Takes [request] as input and returns the generated email
  Future<bool> generateEmailResponse(EmailRequestEntity request) async {
    if (_state == AiEmailState.loading) {
      debugPrint(
        '[Khang] generateEmailResponse: Already loading, skip request',
      );
      return false;
    }

    try {
      debugPrint(
        '[Khang] generateEmailResponse: Start - action: ${request.action}',
      );
      _setState(AiEmailState.loading);

      final response = await aiEmailUsecase.call(request);

      debugPrint(
        '[Khang] generateEmailResponse: Success - email length: ${response.email.length}, remaining usage: ${response.remainingUsage}',
      );

      _response = response;
      _errorMessage = null;
      _setState(AiEmailState.success);

      return true;
    } catch (e, stackTrace) {
      debugPrint('[Khang] generateEmailResponse: Error - $e');
      debugPrintStack(stackTrace: stackTrace);

      _errorMessage = e.toString();
      _response = null;
      _setState(AiEmailState.failure);

      return false;
    }
  }

  /// Call AI Email API to generate reply ideas
  /// Takes [request] as input and returns a list of suggested reply ideas
  Future<bool> generateReplyIdeas(SuggestReplyIdeaRequestEntity request) async {
    if (_state == AiEmailState.loading) {
      debugPrint('[Khang] generateReplyIdeas: Already loading, skip request');
      return false;
    }

    try {
      debugPrint(
        '[Khang] generateReplyIdeas: Start - action: ${request.action}',
      );
      _setState(AiEmailState.loading);

      final response = await sugguestReplyIdeaUsecase.call(request);

      debugPrint(
        '[Khang] generateReplyIdeas: Success - ideas count: ${response.ideaCount}',
      );

      _suggestReplyIdeaResponse = response;
      _errorMessage = null;
      _setState(AiEmailState.success);

      return true;
    } catch (e, stackTrace) {
      debugPrint('[Khang] generateReplyIdeas: Error - $e');
      debugPrintStack(stackTrace: stackTrace);

      _errorMessage = e.toString();
      _suggestReplyIdeaResponse = null;
      _setState(AiEmailState.failure);

      return false;
    }
  }

  /// Reset viewmodel state
  void resetState() {
    debugPrint('[Khang] resetState: Resetting to initial state');
    _state = AiEmailState.initial;
    _response = null;
    _suggestReplyIdeaResponse = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
