import 'package:khtn_ai_final_project/data/datasources/remote/prompt_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';

class PromptRepositoryImpl implements PromptRepository {
  final PromptRemoteDataSource remoteDataSource;
  PromptRepositoryImpl(this.remoteDataSource);

  @override
  Future<PromptResponse> getPrompts(PromptRequest request) async {
    final response = await remoteDataSource.getPrompts(request);
    return response;
  }
}
