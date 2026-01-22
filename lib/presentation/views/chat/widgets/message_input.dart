import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khtn_ai_final_project/presentation/views/chat/widgets/custom_input_message.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_view_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/message_input_view_model.dart';  

class MessageInput extends StatefulWidget {
  final void Function(String, List<PlatformFile>) onSend;

  const MessageInput({super.key, required this.onSend});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  late final TextEditingController _controller;
  late final MessageInputViewModel _viewModel;
  final FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _viewModel = MessageInputViewModel(inputController: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty && _viewModel.files.isEmpty) {
      return;
    }

    widget.onSend(text, _viewModel.files.toList());
    _controller.clear();
    _viewModel.clearFiles();
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([_viewModel, _controller]),
      builder: (context, child) => _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final chatViewModel = context.watch<ChatViewModel>();
    final isBusy = chatViewModel.isBusy;
    final inputMessage = chatViewModel.inputMessage;
    
    // Calculate hasText directly from controller
    final hasText = _controller.text.trim().isNotEmpty;
    final canSend = hasText;

    // Update controller text if inputMessage changes
    if (inputMessage.isNotEmpty && _controller.text != inputMessage) {
      _controller.text = inputMessage;
      if (inputMessage.isNotEmpty) {
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: inputMessage.length),
        );
      }
      // Clear the input message after setting it
      chatViewModel.setInputMessage('');
    }

    return SafeArea(
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display selected files if any
            if (_viewModel.files.isNotEmpty)
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
                      itemCount: _viewModel.files.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final file = _viewModel.files[index];
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
                                onPressed: () {
                                  if (index < _viewModel.files.length) {
                                    _viewModel.removeFileAt(index);
                                  }
                                },
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
                  canSend: canSend,
                  onAttachFile: () async {
                    if (isBusy) return;
                    // Handle add button press - allow multiple file selection
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(allowMultiple: true);

                    if (result != null) {
                      try {
                        _viewModel.addFiles(result.files);
                      } catch (_) {}
                      debugPrint("Selected ${result.files.length} file(s)");
                    } else {
                      debugPrint("No file selected");
                    }
                  },
                  onSend: (message) {
                    _handleSend();
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
