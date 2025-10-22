import 'package:flutter/material.dart';

class TermsCheckbox extends StatelessWidget {
  final bool? isChecked;
  final ValueChanged<bool?>? onChanged;

  const TermsCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 1.0,
              child: Checkbox(
                value: isChecked,
                onChanged: onChanged,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const Text(
              "I agree to the Terms of Service and Privacy Policy",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
