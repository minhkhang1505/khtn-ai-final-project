import 'package:khtn_ai_final_project/data/models/task_planning_response_model.dart';

class AgentChatSession {
  final String sessionId;
  final String agentId;
  final String agentName;
  final DateTime createdAt;
  final List<AgentChatSessionMessage> messages;

  AgentChatSession({
    required this.sessionId,
    required this.agentId,
    required this.agentName,
    required this.createdAt,
    required this.messages,
  });

  factory AgentChatSession.fromJson(Map<String, dynamic> json) {
    return AgentChatSession(
      sessionId: json['sessionId'] as String,
      agentId: json['agentId'] as String,
      agentName: json['agentName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      messages: (json['messages'] as List<dynamic>)
          .map((m) => AgentChatSessionMessage.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'agentId': agentId,
      'agentName': agentName,
      'createdAt': createdAt.toIso8601String(),
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }
}

class AgentChatSessionMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final TaskPlanningResponse? taskPlanningData;

  AgentChatSessionMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.taskPlanningData,
  });

  factory AgentChatSessionMessage.fromJson(Map<String, dynamic> json) {
    return AgentChatSessionMessage(
      text: json['text'] as String,
      isUser: json['isUser'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      taskPlanningData: json['taskPlanningData'] != null
          ? TaskPlanningResponse.fromJson(json['taskPlanningData'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'taskPlanningData': taskPlanningData?.toJson(),
    };
  }
}
