import 'package:flutter/foundation.dart';
import 'package:khtn_ai_final_project/data/mappers/prompt_mapper.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/domain/usecases/prompts/get_prompt_usecase.dart';

class PromptViewmodel extends ChangeNotifier {
  final GetPromptUseCase getPromptUseCase;

  PromptViewmodel({required this.getPromptUseCase});

  final List<PromptEntity> _prompts = [];
  List<PromptEntity>? get prompts => _prompts;

  double limit = 20;
  double offset = 0;
  bool isLoading = false;
  bool hasNext = false;

  Future<bool> getAllPrompts() async {
    if (isLoading) return false;
    isLoading = true;
    notifyListeners();
    try {
      final requestObject = PromptRequest(limit: limit, offset: offset);
      final response = await getPromptUseCase.call(requestObject);
      hasNext = response.hasNext;
      offset += limit;
      _prompts.addAll(response.items.toEntityList());
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('PromptViewmodel: Error fetching prompts - $e');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Add your methods here
}
