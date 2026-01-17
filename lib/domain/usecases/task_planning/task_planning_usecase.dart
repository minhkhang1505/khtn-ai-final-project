import 'package:khtn_ai_final_project/domain/repositories/task_planning_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TaskPlanningUseCase {
  final TaskPlanningRepository taskPlanningRepository;
  
  TaskPlanningUseCase({required this.taskPlanningRepository});

  Future<String> planTask(String request) async {
    return await taskPlanningRepository.planTask(request);
  }
}
