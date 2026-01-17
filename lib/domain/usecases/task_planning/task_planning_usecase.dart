import 'package:khtn_ai_final_project/data/models/task_planning_response_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/task_planning_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TaskPlanningUseCase {
  final TaskPlanningRepository taskPlanningRepository;
  
  TaskPlanningUseCase({required this.taskPlanningRepository});

  Future<TaskPlanningResponse> planTask(String request) async {
    return await taskPlanningRepository.planTask(request);
  }
}
