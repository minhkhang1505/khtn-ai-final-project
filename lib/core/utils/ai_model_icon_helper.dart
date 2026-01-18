import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AiModelIconHelper {
  // Keep a trailing slash to avoid path mistakes when concatenating
  static const String _basePath = 'assets/icons/';

  static Widget iconForModel(
    String name, {
    double size = 24,
    Color? color,
  }) {
    final key = name.toLowerCase();

    String asset = '${_basePath}ic_gpt.svg';
    
    if (key.contains('gpt')) {
      asset = '${_basePath}ic_gpt.svg';
    } else if (key.contains('claude')) {
      asset = '${_basePath}ic_claude.svg';
    } else if (key.contains('gemini')) {
      asset = '${_basePath}ic_gemini.svg';
    } else {
      asset = '${_basePath}ic_bot.svg';
    }

    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      // If the asset is missing or unreadable, gracefully fall back
      // to a Material icon so the UI never crashes.
      placeholderBuilder: (context) => Icon(
        Icons.auto_awesome,
        size: size,
        color: color,
      ),
      // For newer flutter_svg versions, errorBuilder is the reliable hook
      // to handle load/parsing errors.
      // ignore: deprecated_member_use
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.auto_awesome,
        size: size,
        color: color,
      ),
    );
  }
}
