class TaskPlanningResponse {
  final String title;
  final String description;
  final List<TaskItem> tasks;
  final int totalHours;

  TaskPlanningResponse({
    required this.title,
    required this.description,
    required this.tasks,
    required this.totalHours,
  });

  factory TaskPlanningResponse.fromJson(Map<String, dynamic> json) {
    return TaskPlanningResponse(
      title: json['title'] as String,
      description: json['description'] as String,
      tasks: (json['tasks'] as List<dynamic>)
          .map((item) => TaskItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalHours: json['total_hours'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'tasks': tasks.map((task) => task.toJson()).toList(),
      'total_hours': totalHours,
    };
  }
}

class TaskItem {
  final int id;
  final String name;
  final int estimateHours;

  TaskItem({
    required this.id,
    required this.name,
    required this.estimateHours,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      id: json['id'] as int,
      name: json['name'] as String,
      estimateHours: json['estimate_hours'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'estimate_hours': estimateHours,
    };
  }
}
