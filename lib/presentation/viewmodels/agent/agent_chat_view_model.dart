import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'package:khtn_ai_final_project/data/models/agent_chat_session_model.dart';
import 'package:khtn_ai_final_project/data/models/task_planning_response_model.dart';
import 'package:khtn_ai_final_project/domain/usecases/task_planning/task_planning_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AgentChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final TaskPlanningResponse? taskPlanningData;

  AgentChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.taskPlanningData,
  });
}

class AgentChatViewModel extends ChangeNotifier {
  final AgentModel agent;
  final TaskPlanningUseCase taskPlanningUseCase;

  AgentChatViewModel({
    required this.agent,
    required this.taskPlanningUseCase,
  });

  late String _currentSessionId;
  final List<AgentChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;
  final ScrollController scrollController = ScrollController();

  List<AgentChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get currentSessionId => _currentSessionId;

  @override
  void notifyListeners() {
    // Auto-save session on each change
    _saveSession();
    super.notifyListeners();
  }

  void initSession() {
    _currentSessionId = const Uuid().v4();
  }

  Future<void> loadPreviousSession() async {
    try {
      final sessions = await getAgentSessions();
      if (sessions.isNotEmpty) {
        final lastSession = sessions.first;
        _currentSessionId = lastSession.sessionId;
        _messages.clear();
        for (final sessionMsg in lastSession.messages) {
          _messages.add(AgentChatMessage(
            text: sessionMsg.text,
            isUser: sessionMsg.isUser,
            timestamp: sessionMsg.timestamp,
            taskPlanningData: sessionMsg.taskPlanningData,
          ));
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading previous session: $e');
    }
  }

  void addMessage(String text, {required bool isUser, TaskPlanningResponse? taskData}) {
    final message = AgentChatMessage(
      text: text,
      isUser: isUser,
      timestamp: DateTime.now(),
      taskPlanningData: taskData,
    );
    _messages.add(message);
    _scrollToBottom();
    notifyListeners();
  }

  Future<void> sendMessage(String userMessage) async {
    try {
      // Add user message
      addMessage(userMessage, isUser: true);
      
      // Set loading state
      setLoading(true);
      clearError();

      // Call the task planning API
      final response = await taskPlanningUseCase.planTask(userMessage);

      // Format the response as a message
      final formattedMessage = _formatTaskPlanningResponse(response);
      
      // Add agent response with task data
      addMessage(formattedMessage, isUser: false, taskData: response);
      
      setLoading(false);
    } catch (e) {
      setLoading(false);
      setError('Failed to get response: ${e.toString()}');
      // Add error message to chat
      addMessage('Error: ${e.toString()}', isUser: false);
    }
  }

  String _formatTaskPlanningResponse(TaskPlanningResponse response) {
    final buffer = StringBuffer();
    buffer.writeln('📋 ${response.title}');
    buffer.writeln('${response.description}\n');
    buffer.writeln('Tasks:');
    for (int i = 0; i < response.tasks.length; i++) {
      final task = response.tasks[i];
      buffer.writeln('${i + 1}. ${task.name} (${task.estimateHours}h)');
    }
    buffer.writeln('\n⏱️ Total: ${response.totalHours} hours');
    return buffer.toString();
  }

  Future<void> _saveSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert messages to session format
      final sessionMessages = _messages.map((msg) {
        return AgentChatSessionMessage(
          text: msg.text,
          isUser: msg.isUser,
          timestamp: msg.timestamp,
          taskPlanningData: msg.taskPlanningData,
        );
      }).toList();

      final session = AgentChatSession(
        sessionId: _currentSessionId,
        agentId: agent.id,
        agentName: agent.name,
        createdAt: DateTime.now(),
        messages: sessionMessages,
      );

      // Save as JSON
      final sessionJson = jsonEncode(session.toJson());
      await prefs.setString('agent_chat_session_${_currentSessionId}', sessionJson);
      
      // Keep track of all session IDs for the agent
      final sessionIds = prefs.getStringList('agent_${agent.id}_session_ids') ?? [];
      if (!sessionIds.contains(_currentSessionId)) {
        sessionIds.add(_currentSessionId);
        await prefs.setStringList('agent_${agent.id}_session_ids', sessionIds);
      }
    } catch (e) {
      debugPrint('Error saving session: $e');
    }
  }

  Future<AgentChatSession?> loadSession(String sessionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionJson = prefs.getString('agent_chat_session_$sessionId');
      
      if (sessionJson == null) return null;
      
      final decoded = jsonDecode(sessionJson) as Map<String, dynamic>;
      final session = AgentChatSession.fromJson(decoded);
      
      return session;
    } catch (e) {
      debugPrint('Error loading session: $e');
      return null;
    }
  }

  Future<List<AgentChatSession>> getAgentSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionIds = prefs.getStringList('agent_${agent.id}_session_ids') ?? [];
      
      final sessions = <AgentChatSession>[];
      for (final sessionId in sessionIds) {
        final session = await loadSession(sessionId);
        if (session != null) {
          sessions.add(session);
        }
      }
      
      // Sort by creation time (newest first)
      sessions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return sessions;
    } catch (e) {
      debugPrint('Error getting sessions: $e');
      return [];
    }
  }

  Future<void> deleteSession(String sessionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('agent_chat_session_$sessionId');
      
      final sessionIds = prefs.getStringList('agent_${agent.id}_session_ids') ?? [];
      sessionIds.remove(sessionId);
      await prefs.setStringList('agent_${agent.id}_session_ids', sessionIds);
    } catch (e) {
      debugPrint('Error deleting session: $e');
    }
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
