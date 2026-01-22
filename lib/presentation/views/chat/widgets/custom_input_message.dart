import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_view_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt/prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/chat/widgets/show_prompt_modal_bottom_sheet.dart';
import 'package:khtn_ai_final_project/presentation/views/chat/widgets/slash_command_to_show_prompt.dart';
import 'package:provider/provider.dart';

final double ICON_SIZE = 22.0;

class CustomInputMessage extends StatefulWidget {
  final void Function(String) onSend;
  final TextEditingController? controller;
  final void Function() onAttachFile;
  final bool canSend;
  const CustomInputMessage({
    super.key,
    required this.onSend,
    this.controller,
    required this.onAttachFile,
    this.canSend = true,
  });

  @override
  State<CustomInputMessage> createState() => _CustomInputMessageState();
}

class _CustomInputMessageState extends State<CustomInputMessage> {
  late final TextEditingController _controller;
  final FocusNode _textFocusNode = FocusNode();

  OverlayEntry? _overlayEntry;
  List<SlashCommand>? _suggestions = [];
  Timer? _debounce;

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

  void _onChanged(String value) {
    final cursor = _controller.selection.baseOffset;
    if (cursor < 0) return;

    final prefix = value.substring(0, cursor);
    final match = RegExp(r'\/(\w*)$').firstMatch(prefix);

    if (match == null) {
      _removeOverlay();
      return;
    }

    final keyword = match.group(1) ?? '';
    _debouncedFetch(keyword);
    // Handle text change if needed
  }

  void _debouncedFetch(String keyword) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final promptVM = context.read<PromptViewmodel>();
      final results = await promptVM.getAllPrompts();
      if (!mounted) return;
      if (results) {
        final prompts = promptVM.prompts;
        final filtered = prompts
            ?.where(
              (prompt) =>
                  prompt.title.toLowerCase().contains(keyword.toLowerCase()),
            )
            .toList();
        final slashCommands = filtered
            ?.map(
              (prompt) => SlashCommand(
                command: prompt.title,
                title: prompt.description ?? '',
              ),
            )
            .toList();
        setState(() => _suggestions = slashCommands);
        if ((slashCommands?.length ?? 0) > 0) {
          _showOverlay();
        } else {
          _removeOverlay();
        }
      } else {
        setState(() => _suggestions = []);
        _removeOverlay();
      }
    });
  }

  void _showOverlay() {
    _overlayEntry?.remove();

    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        left: 16,
        bottom: 80,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320, maxHeight: 350),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(8),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions?.length,
              itemBuilder: (_, i) {
                final prompt = _suggestions?[i];
                return ListTile(
                  title: Text('${prompt?.title}'),
                  onTap: () => _insertCommand(prompt?.title ?? ''),
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _insertCommand(String command) {
    final cursor = _controller.selection.baseOffset;
    if (cursor < 0) return;

    final text = _controller.text;
    final prefix = text.substring(0, cursor);
    final suffix = text.substring(cursor);

    final match = RegExp(r'\/(\w*)$').firstMatch(prefix);
    if (match == null) return;

    final newPrefix = '${prefix.substring(0, match.start)}/$command ';

    final newText = newPrefix + suffix;
    final newCursorPosition = newPrefix.length;

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );

    _removeOverlay();
    _textFocusNode.requestFocus();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            focusNode: _textFocusNode,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 7,
            onChanged: _onChanged,
            decoration: InputDecoration(
              hintText: "Type your message...",
              filled: true,
              enabled: !isBusy,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: isBusy ? null : () => widget.onAttachFile(),
                      icon: SvgPicture.asset(
                        'assets/icons/ic_add_file_chat.svg',
                        width: ICON_SIZE,
                        height: ICON_SIZE,
                        colorFilter: ColorFilter.mode(
                          isBusy
                              ? colorScheme.onSurface.withOpacity(0.38)
                              : colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: isBusy
                          ? null
                          : () => ShowPromptModalBottomSheet.show(context),
                      icon: SvgPicture.asset(
                        'assets/icons/ic_add_prompt_chat.svg',
                        width: ICON_SIZE,
                        height: ICON_SIZE,
                        colorFilter: ColorFilter.mode(
                          isBusy
                              ? colorScheme.onSurface.withOpacity(0.38)
                              : colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.send_rounded),
                  color: widget.canSend && !isBusy
                      ? colorScheme.primary
                      : colorScheme.onSurface.withOpacity(0.38),
                  onPressed: (isBusy || !widget.canSend) ? null : _handleSend,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
