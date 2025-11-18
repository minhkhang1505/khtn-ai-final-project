import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import '../../../data/models/chat_model.dart';
import 'widgets/chat_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/services/api_service.dart';
import 'widgets/chat_drawer.dart';
import 'widgets/message_input.dart';

/// Chat page - Main chat interface
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessageModel> _messages = [];
 
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void onAddNewChat() {
    // TODO: Handle add new chat
  }

  void _sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    final userMessage = ChatMessageModel.sample();
    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    final reply = await ApiService.sendMessage(message);
    final replyMessage = ChatMessageModel.sampleWithData(reply, 'assistant');

    if (!mounted) return;

    setState(() {
      _messages.add(replyMessage);
      _isLoading = false;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: ChatAppBar(onAddNewChat: onAddNewChat),
      drawer: ChatDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: ResponsiveHelper.horizontalPadding(context), 
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.role == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
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
                );
              },
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),

          // Message input field
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: ResponsiveHelper.horizontalPadding(context),
              child: MessageInput(
                onSend: (message) => _sendMessage(message),
                onAddPressed: () {
                  // TODO: Handle add button press
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
