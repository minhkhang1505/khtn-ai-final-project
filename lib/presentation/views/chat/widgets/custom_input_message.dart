import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat_view_model.dart';
import 'package:provider/provider.dart';

class CustomInputMessage extends StatefulWidget {
  final void Function(String) onSend;
  const CustomInputMessage({super.key, required this.onSend});

  @override
  State<CustomInputMessage> createState() => _CustomInputMessageState();
}

class _CustomInputMessageState extends State<CustomInputMessage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    widget.onSend(text);
    _controller.clear();
  }

  void _onChanged(String value) {
    // Handle text change if needed
  }

  @override
  Widget build(BuildContext context) {
    final vmWatch = context.watch<ChatViewModel>();
    final colorScheme = Theme.of(context).colorScheme;
    final isBusy = vmWatch.isBusy;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh.withAlpha(200),
        border: Border.all(color: colorScheme.outline.withAlpha(50)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            focusNode: _textFocusNode,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: null,
            onChanged: _onChanged,
            decoration: InputDecoration(
              hintText: "Type your message...",
              filled: true,
              enabled: !isBusy,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_photo_alternate_sharp),
              ),
              IconButton(
                icon: const Icon(Icons.send_rounded),
                color: colorScheme.primary,
                onPressed: isBusy ? null : _handleSend,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
