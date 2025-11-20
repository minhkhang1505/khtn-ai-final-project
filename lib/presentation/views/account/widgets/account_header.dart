import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khtn_ai_final_project/core/constants/account_constants.dart';
import 'package:khtn_ai_final_project/data/models/user_models.dart';

/// Header widget displaying user profile information
class AccountHeader extends StatelessWidget {
  final bool isProUser;
  final UserResponse? user;

  const AccountHeader({super.key, required this.isProUser, this.user});

  @override
  Widget build(BuildContext context) {
    final displayUser =
        user ??
        UserResponse(
          id: '0',
          email: '',
          username: 'Guest',
          roles: [],
          geo: Geo(lat: '0', long: '0'),
        );
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
                displayUser.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(displayUser.email, style: const TextStyle(fontSize: 16)),
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
