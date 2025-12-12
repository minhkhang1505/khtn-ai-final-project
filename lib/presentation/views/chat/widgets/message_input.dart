import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khtn_ai_final_project/presentation/views/chat/widgets/custom_input_message.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat_view_model.dart';

class MessageInput extends StatefulWidget {
  final void Function(String) onSend;
  final TextEditingController? controller;

  const MessageInput({super.key, required this.onSend, this.controller});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
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
    final vm = context.read<ChatViewModel>();
    if (text.isEmpty && vm.files.isEmpty) {
      return;
    }

    widget.onSend(text);
    _controller.clear();
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final vm = context.read<ChatViewModel>();
    final vmWatch = context.watch<ChatViewModel>();
    final isBusy = vmWatch.isBusy;
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display selected files if any
            if (vmWatch.files.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 120,
                    maxWidth: MediaQuery.of(context).size.width * 0.4,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: vmWatch.files.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final file = vmWatch.files[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: colorScheme.outlineVariant,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.insert_drive_file,
                                color: colorScheme.primary,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      file.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: colorScheme.onSurface,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      _formatFileSize(file.size),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                iconSize: 16,
                                color: colorScheme.onSurfaceVariant,
                                onPressed: () => vm.removeFileAt(index),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 24,
                                  minHeight: 24,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            // Let the input grow naturally without hard height caps to avoid overflow
            Flexible(
              fit: FlexFit.loose,
              child: Focus(
                onKeyEvent: (node, event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.enter) {
                    if (HardwareKeyboard.instance.isShiftPressed) {
                      final newValue = '${_controller.text}\n';
                      _controller.text = newValue;
                      _controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: newValue.length),
                      );
                      return KeyEventResult
                          .handled; // Prevent TextField receiving the event
                    } else {
                      _handleSend();
                      return KeyEventResult
                          .handled; // Prevent TextField receiving the event
                    }
                  }
                  return KeyEventResult.ignored;
                },
                child: CustomInputMessage(
                  controller: _controller,
                  onAttachFile: () async {
                    if (isBusy) return;
                    // Handle add button press - allow multiple file selection
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(allowMultiple: true);

                    if (result != null) {
                      try {
                        vm.addFiles(result.files);
                      } catch (_) {}
                      debugPrint("Selected ${result.files.length} file(s)");
                    } else {
                      debugPrint("No file selected");
                    }
                  },
                  onSend: (message) {
                    vm.sendMessage(message);
                    vm.clearFiles();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
