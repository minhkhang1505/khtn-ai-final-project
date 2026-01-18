import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/custom_text_form_field.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final String? error;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        CustomTextFormField(
          controller: controller,
          hintText: hintText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          suffixIcon: suffixIcon,
          onSuffixIconPressed: onSuffixIconPressed,
          error: error,
        ),
      ],
    );
  }
}
