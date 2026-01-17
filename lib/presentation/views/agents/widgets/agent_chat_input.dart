import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'package:khtn_ai_final_project/presentation/views/agents/widgets/custom_agent_input_message.dart';

class AgentChatInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final AgentModel agent;
  final bool isLoading;

  const AgentChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.agent,
    this.isLoading = false,
  });

  @override
  State<AgentChatInput> createState() => _AgentChatInputState();
}

class _AgentChatInputState extends State<AgentChatInput> {
  late final FocusNode _textFocusNode;

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (widget.isLoading) return;
    widget.onSend();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Focus(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.enter) {
            if (HardwareKeyboard.instance.isShiftPressed) {
              final newValue = '${widget.controller.text}\n';
              widget.controller.text = newValue;
              widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: newValue.length),
              );
              return KeyEventResult.handled;
            } else {
              _handleSend();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: CustomAgentInputMessage(
          controller: widget.controller,
          onSend: (_) {
            _handleSend();
          },
          isLoading: widget.isLoading,
        ),
      ),
    );
  }
}
