import 'package:flutter/material.dart';

class CreateBotPage extends StatelessWidget {
  const CreateBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bot'),
      ),
      body: const Center(
        child: Text('Edit Bot Page Content Here'),
      ),
    );
  }
}