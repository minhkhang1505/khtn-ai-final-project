import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/agent/agent_chat_view_model.dart';
import 'widgets/agent_chat_app_bar.dart';
import 'widgets/agent_chat_message_list.dart';
import 'widgets/agent_chat_input.dart';

class AgentChatPage extends StatefulWidget {
  final AgentModel agent;

  const AgentChatPage({super.key, required this.agent});

  @override
  State<AgentChatPage> createState() => _AgentChatPageState();
}

class _AgentChatPageState extends State<AgentChatPage> {
  late final AgentChatViewModel _viewModel;
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _viewModel = AgentChatViewModel(
      agent: widget.agent,
      taskPlanningUseCase: sl(),
    );
    _viewModel.initSession();
    _messageController = TextEditingController();
    
    // Load previous session if it exists
    _loadPreviousSession();
  }

  Future<void> _loadPreviousSession() async {
    await _viewModel.loadPreviousSession();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text;
    _messageController.clear();

    // Call the API through the view model
    _viewModel.sendMessage(userMessage);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AgentChatAppBar(agent: widget.agent),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListenableBuilder(
              listenable: _viewModel,
              builder: (context, _) => AgentChatMessageList(
                messages: _viewModel.messages,
                scrollController: _viewModel.scrollController,
              ),
            ),
          ),
          // Message Input
          Container(
            padding: ResponsiveHelper.horizontalPadding(context),
            child: ListenableBuilder(
              listenable: _viewModel,
              builder: (context, _) => AgentChatInput(
                controller: _messageController,
                onSend: _sendMessage,
                agent: widget.agent,
                isLoading: _viewModel.isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
