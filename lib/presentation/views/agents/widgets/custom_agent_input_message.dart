import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class CustomAgentInputMessage extends StatefulWidget {
  final void Function(String) onSend;
  final TextEditingController? controller;
  final bool isLoading;

  const CustomAgentInputMessage({
    super.key,
    required this.onSend,
    this.controller,
    this.isLoading = false,
  });

  @override
  State<CustomAgentInputMessage> createState() =>
      _CustomAgentInputMessageState();
}

class _CustomAgentInputMessageState extends State<CustomAgentInputMessage> {
  late final TextEditingController _controller;
  final FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _textFocusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isBusy = widget.isLoading;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh.withAlpha(200),
        border: Border.all(color: colorScheme.outline.withAlpha(50)),
        borderRadius: AppBorderRadius.large,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _textFocusNode,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 7,
              enabled: !isBusy,
              decoration: InputDecoration(
                hintText: "Type your message...",
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                border: OutlineInputBorder(
                  borderRadius: AppBorderRadius.large,
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: isBusy
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorScheme.primary,
                      ),
                    ),
                  )
                : const Icon(Icons.send_rounded),
            color: colorScheme.primary,
            onPressed: isBusy ? null : _handleSend,
          ),
        ],
      ),
    );
  }
}
