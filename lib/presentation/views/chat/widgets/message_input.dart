import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<void> _capturePhoto() async {
    final ImagePicker picker = ImagePicker();
    try {
      // Capture photo with reduced quality to minimize file size (avoid 413 error)
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80, // Reduce quality from 100 to 80 to compress file
      );
      if (photo != null) {
        // Create a PlatformFile with the file path
        final file = File(photo.path);
        final bytes = await file.readAsBytes();
        
        final platformFile = PlatformFile(
          name: photo.name,
          size: bytes.length,
          bytes: bytes,
          path: photo.path, // Important: set the path so the upload works
        );
        
        _viewModel.addFiles([platformFile]);
        debugPrint("Photo captured: ${photo.name} from path: ${photo.path}, size: ${_formatFileSize(bytes.length)}");
      }
    } catch (e) {
      debugPrint("Error capturing photo: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error capturing photo: $e'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _captureScreenshot() async {
    try {
      // Wait for the current frame to complete to avoid paint assertion errors
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Find the RenderObject at the root of the widget tree
      final renderObject = context.findRenderObject();
      
      if (renderObject == null) {
        throw Exception('Could not capture screenshot: RenderObject not found');
      }
      
      // Find the first RenderRepaintBoundary ancestor
      RenderRepaintBoundary? boundary;
      
      // Try to find an existing RepaintBoundary in the tree
      context.visitAncestorElements((element) {
        final renderObj = element.renderObject;
        if (renderObj is RenderRepaintBoundary) {
          boundary = renderObj;
          return false; // Stop searching
        }
        return true; // Continue searching
      });
      
      // If no boundary found, navigate to the root and wrap it
      if (boundary == null) {
        // Find the root RenderObject
        var current = renderObject;
        while (current.parent is RenderObject) {
          current = current.parent as RenderObject;
        }
        
        // If the root is already a RepaintBoundary, use it
        if (current is RenderRepaintBoundary) {
          boundary = current;
        } else {
          throw Exception('No RepaintBoundary found in widget tree. Please wrap your app with RepaintBoundary.');
        }
      }
      
      // At this point, boundary must be non-null
      final repaintBoundary = boundary!;
      
      // Ensure the boundary doesn't need to paint before capturing
      if (repaintBoundary.debugNeedsPaint) {
        throw Exception('Widget is still being painted. Please try again.');
      }
      
      // Capture the image with the boundary
      final image = await repaintBoundary.toImage(pixelRatio: 1.5);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData == null) {
        throw Exception('Failed to convert image to bytes');
      }
      
      final bytes = byteData.buffer.asUint8List();
      
      // Generate a filename with timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'screenshot_$timestamp.png';
      
      // Save to temporary directory
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      
      final platformFile = PlatformFile(
        name: fileName,
        size: bytes.length,
        bytes: bytes,
        path: filePath,
      );
      
      _viewModel.addFiles([platformFile]);
      debugPrint("Screenshot captured: $fileName from path: $filePath, size: ${_formatFileSize(bytes.length)}");
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Screenshot captured!'),
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error capturing screenshot: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error capturing screenshot: $e'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
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
                  onCapturePhoto: () {
                    _capturePhoto();
                  },
                  onCaptureScreenshot: () {
                    _captureScreenshot();
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
