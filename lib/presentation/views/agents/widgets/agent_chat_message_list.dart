import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/agent/agent_chat_view_model.dart';

class AgentChatMessageList extends StatefulWidget {
  final List<AgentChatMessage> messages;
  final ScrollController scrollController;

  const AgentChatMessageList({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  State<AgentChatMessageList> createState() => _AgentChatMessageListState();
}

class _AgentChatMessageListState extends State<AgentChatMessageList> {
  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Message copied to clipboard'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (widget.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: colorScheme.onSurfaceVariant.withAlpha(100),
            ),
            const SizedBox(height: 16),
            Text(
              'Ask agent to generate plan',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Instructions: Type your request in the input box below to let the agent generate a plan for you.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withAlpha(128),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: widget.scrollController,
      padding: ResponsiveHelper.horizontalPadding(context),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final msg = widget.messages[index];
        return AgentMessageBubble(
          message: msg,
          onCopy: () => _copyToClipboard(context, msg.text),
        );
      },
    );
  }
}

/// Individual message bubble with hover-to-show copy button
class AgentMessageBubble extends StatefulWidget {
  final AgentChatMessage message;
  final VoidCallback onCopy;

  const AgentMessageBubble({
    super.key,
    required this.message,
    required this.onCopy,
  });

  @override
  State<AgentMessageBubble> createState() => _AgentMessageBubbleState();
}

class _AgentMessageBubbleState extends State<AgentMessageBubble> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final msg = widget.message;

    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Column(
          crossAxisAlignment: msg.isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              width: msg.isUser ? null : double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: msg.isUser
                    ? colorScheme.primaryFixedDim
                    : colorScheme.secondaryFixedDim,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: msg.isUser
                      ? const Radius.circular(12)
                      : Radius.zero,
                  bottomRight: msg.isUser
                      ? Radius.zero
                      : const Radius.circular(12),
                ),
              ),
              child: Text(
                msg.text,
                style: TextStyle(
                  color: msg.isUser
                      ? colorScheme.onPrimaryFixed
                      : colorScheme.onSecondaryFixed,
                  fontSize: 16,
                ),
              ),
            ),
            // Copy button - only visible on hover
            AnimatedOpacity(
              opacity: _isHovered ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
                child: Tooltip(
                  message: 'Copy message',
                  child: TextButton.icon(
                    onPressed: _isHovered ? widget.onCopy : null,
                    icon: Icon(
                      Icons.copy,
                      size: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    label: const SizedBox.shrink(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
