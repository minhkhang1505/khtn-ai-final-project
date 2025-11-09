import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khtn_ai_final_project/data/models/account_models.dart';
import 'package:khtn_ai_final_project/core/constants/account_constants.dart';

/// Header widget displaying user profile information
class AccountHeader extends StatelessWidget {
  final User user;
  final bool isProUser;

  const AccountHeader({super.key, required this.user, required this.isProUser});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
        const Spacer(),
        if (isProUser)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: colorScheme.tertiary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_pro.svg',
                  colorFilter: ColorFilter.mode(Colors.amber, BlendMode.srcIn),
                  width: 16,
                  height: 16,
                ),
                SizedBox(width: 4),
                Text(
                  "Pro",
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
