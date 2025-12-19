import 'package:flutter/material.dart';

class IconAiModelHelper {
  static IconData iconForModel(String name) {
    final key = name.toLowerCase();
    if (key.contains('gpt')) return Icons.smart_toy;
    if (key.contains('dall') || key.contains('image')) return Icons.image;
    if (key.contains('audio') || key.contains('whisper')) return Icons.mic;
    return Icons.auto_awesome;
  }
}