import 'package:flutter/material.dart';

class AgentMessageInputViewModel extends ChangeNotifier {
  final TextEditingController? inputController;

  AgentMessageInputViewModel({this.inputController});

  void dispose() {
    super.dispose();
  }
}
