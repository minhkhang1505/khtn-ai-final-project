import 'dart:convert';
import 'package:khtn_ai_final_project/data/datasources/remote/task_planning_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/task_planning_response_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/task_planning_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TaskPlanningRepository)
class TaskPlanningRepositoryImpl implements TaskPlanningRepository {
  final TaskPlanningRemoteDataSource remoteDataSource;

  TaskPlanningRepositoryImpl(this.remoteDataSource);

  @override
  Future<TaskPlanningResponse> planTask(String request) async {
    final responseJson = await remoteDataSource.planTask(request);
    final parsed = jsonDecode(responseJson) as Map<String, dynamic>;
    return TaskPlanningResponse.fromJson(parsed);
  }
}
