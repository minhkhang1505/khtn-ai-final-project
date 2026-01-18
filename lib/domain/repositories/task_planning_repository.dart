import 'package:khtn_ai_final_project/data/models/task_planning_response_model.dart';

abstract class TaskPlanningRepository {
  Future<TaskPlanningResponse> planTask(String request);
}
