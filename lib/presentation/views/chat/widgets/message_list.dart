import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat_view_model.dart';
import 'package:khtn_ai_final_project/data/models/chat/chat_model.dart';

/// Message list widget - Displays chat messages
class MessageList extends StatefulWidget {
  final ScrollController scrollController;

  const MessageList({super.key, required this.scrollController});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
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
    return Selector<ChatViewModel, List<ChatMessageModel>>(
      selector: (_, vm) => vm.messages,
      builder: (context, messages, child) {
        return ListView.builder(
          controller: widget.scrollController,
          // context of use: messages should be passed from parent widget
          padding: ResponsiveHelper.horizontalPadding(context),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[index];
            return MessageBubble(
              message: msg,
              onCopy: () => _copyToClipboard(context, msg.content),
            );
          },
        );
      },
    );
  }
}

/// Individual message bubble with hover-to-show copy button
class MessageBubble extends StatefulWidget {
  final ChatMessageModel message;
  final VoidCallback onCopy;

  const MessageBubble({super.key, required this.message, required this.onCopy});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final msg = widget.message;

    return Align(
      alignment: msg.role == 'user'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Column(
          crossAxisAlignment: msg.role == 'user'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              width: msg.role == 'user' ? null : double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              padding: msg.role == 'user'
                  ? const EdgeInsets.all(12)
                  : const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 12,
                      bottom: 12,
                    ),
              decoration: BoxDecoration(
                color: msg.role == 'user'
                    ? colorScheme.primaryFixedDim
                    : colorScheme.secondaryFixedDim,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: msg.role == 'user'
                      ? const Radius.circular(12)
                      : Radius.zero,
                  bottomRight: msg.role == 'user'
                      ? Radius.zero
                      : const Radius.circular(12),
                ),
              ),
              child: Text(
                msg.content,
                style: TextStyle(
                  color: msg.role == 'user'
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
          ],
        ),
      ),
    );
  }
}
