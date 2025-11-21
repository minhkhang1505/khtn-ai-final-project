import 'package:khtn_ai_final_project/data/models/prompt_model.dart';

abstract class PromptRepository {
  Future<PromptResponse> getPrompts(PromptRequest request);
}