import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageInput extends StatefulWidget {
  final void Function(String) onSend; 
  final VoidCallback? onAddPressed; 

  const MessageInput({
    super.key,
    required this.onSend,
    this.onAddPressed,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 150), // ~5 lines
          child: Focus(
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
                if (HardwareKeyboard.instance.isShiftPressed) {
                  final newValue = '${_controller.text}\n';
                  _controller.text = newValue;
                  _controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: newValue.length),
                  );
                  return KeyEventResult.handled; // Prevent TextField receiving the event
                } else {
                  _handleSend();
                  return KeyEventResult.handled; // Prevent TextField receiving the event
                }
              }
              return KeyEventResult.ignored; 
            },
            child: TextField(
              controller: _controller,
              focusNode: _textFocusNode,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Nhập tin nhắn...",
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.grey[700],
                    onPressed: widget.onAddPressed,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded),
                    color: Theme.of(context).primaryColor,
                    onPressed: _handleSend,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
