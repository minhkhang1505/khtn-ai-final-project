import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixIconPressed;
  final String? error;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.maxLines = 1,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.initialValue,
    this.contentPadding,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSuffixIconPressed,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      readOnly: readOnly,
      validator: validator,
      decoration: InputDecoration(
        errorText: error,
        errorMaxLines: 2,
        hintText: hintText,
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withAlpha(140),
          fontSize: 13,
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh.withAlpha(120),
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.medium,
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: onSuffixIconPressed,
                child: Icon(
                  suffixIcon,
                  color: colorScheme.onSurface.withAlpha(140),
                  size: 18,
                ),
              )
            : null,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: colorScheme.onSurface.withAlpha(140),
                size: 18,
              )
            : null,
      ),
    );
  }
}
