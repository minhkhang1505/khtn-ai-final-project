import 'package:flutter/material.dart';
import 'message/message.dart';
import 'package:khtn_ai_final_project/presentation/services/api_service.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/message_input.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/bot_option_menu.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot_view_model.dart';

/// Chat page - Main chat interface
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  final BotViewModel botViewModel = BotViewModel();
  //botViewModel.loadBots();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    botViewModel.loadBots();
  }

  void _sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    final userMessage = Message(text: message, isUser: true);
    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    final reply = await ApiService.sendMessage(message);

    if (!mounted) return;

    setState(() {
      _messages.add(Message(text: reply, isUser: false));
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
    final messageWidth = MediaQuery.of(context).size.width * 0.6;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text("AI Chat"),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(width: 120, child: BotOptionMenu()),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // TODO: Handle add chat button press
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 60,
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: const Text(
                'AI Bots',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Create New Bot'),
              onTap: () {
                // TODO: Handle create new bot
              },
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Chats',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: botViewModel.bots.length,
                itemBuilder: (context, index) {
                  final bot = botViewModel.bots[index];
                  return ListTile(
                    title: Text(bot.name),
                    subtitle: Text(bot.description),
                    trailing: PopupMenuButton<int>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      offset: const Offset(0, 40),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: const [
                              Icon(Icons.share_outlined, size: 20),
                              SizedBox(width: 12),
                              Text('Share'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: const [
                              Icon(Icons.edit_outlined, size: 20),
                              SizedBox(width: 12),
                              Text('Rename'),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          value: 2,
                          child: Row(
                            children: const [
                              Icon(Icons.archive_outlined, size: 20),
                              SizedBox(width: 12),
                              Text('Archive'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 0:
                            debugPrint('Share tapped');
                            break;
                          case 1:
                            debugPrint('Rename tapped');
                            break;
                          case 2:
                            debugPrint('Archive tapped');
                            break;
                          case 3:
                            debugPrint('Delete tapped');
                            break;
                        }
                      },
                      icon: const Icon(Icons.more_horiz),
                    ),
                    onTap: () {
                      // TODO: Handle bot selection
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: messageWidth < 400
                    ? const EdgeInsets.symmetric(horizontal: 8, vertical: 16)
                    : EdgeInsets.symmetric(
                        horizontal:
                            (MediaQuery.of(context).size.width * 0.5) / 2,
                        vertical: 16,
                      ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return Align(
                    alignment: msg.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: msg.isUser ? null : double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: msg.isUser
                          ? const EdgeInsets.all(12)
                          : const EdgeInsets.only(
                              left: 12,
                              right: 12,
                              top: 12,
                              bottom: 12,
                            ),
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
                  );
                },
              ),
            ),

            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),

            Align(
              alignment: Alignment.bottomCenter,
              widthFactor: double.infinity,
              child: Padding(
                padding: messageWidth < 400
                    ? const EdgeInsets.symmetric(horizontal: 0, vertical: 8)
                    : EdgeInsets.symmetric(
                        horizontal:
                            (MediaQuery.of(context).size.width * 0.5) / 2 - 12,
                        vertical: 8,
                      ),
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
      ),
    );
  }
}
