import 'package:flutter/material.dart';

/// Chat page - Main chat interface
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: const Center(
        child: Text('Implement later', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
