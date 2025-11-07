import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/account/models/account_models.dart';
import 'package:khtn_ai_final_project/presentation/views/account/models/account_constants.dart';

/// Header widget displaying user profile information
class AccountHeader extends StatelessWidget {
  final User user;

  const AccountHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: avatarSize,
          height: avatarSize,
          child: CircleAvatar(radius: 40),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(user.email, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
