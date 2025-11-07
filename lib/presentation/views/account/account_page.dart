import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';

final avatarSize = 48.0;

/// Account page - User profile and settings
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final user = User(
      id: '1',
      email: 'user@example.com',
      username: 'Mockuser',
      roles: ['admin', 'user'],
      geo: Geo(lat: '40.7128', long: '-74.0060'),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(
              width: avatarSize,
              height: avatarSize,
              child: CircleAvatar(radius: 40),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(user.email, style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: [
                // Container for upgrade plan
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 6, 0),
                  height: 70,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withAlpha(50),
                    borderRadius: AppBorderRadius.large,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_upgrade.svg',
                        colorFilter: ColorFilter.mode(
                          colorScheme.primary.withAlpha(200),
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        "Upgrade to Pro for unlimited access",
                        style: TextStyle(
                          //TODO: Add style
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          //TODO: Add action
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.outlineVariant.withAlpha(150),
                      width: 1.5,
                    ),
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: AppBorderRadius.large,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subscription",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Free Plan", style: TextStyle(fontSize: 14)),
                              SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: AppBorderRadius.small,
                                ),
                                child: Text(
                                  "Current",
                                  style: TextStyle(
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Limited features",
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurface.withAlpha(140),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.medium,
                          ),
                        ),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/ic_upgrade.svg',
                                        colorFilter: ColorFilter.mode(
                                          colorScheme.onPrimary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text("Upgrade to Pro"),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "\$19.00",
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "/month",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Cancel anytime",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: colorScheme.onSurface
                                              .withAlpha(140),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_upgrade.svg',
                              colorFilter: ColorFilter.mode(
                                colorScheme.onPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                            Text(
                              "Upgrade to Pro",
                              style: TextStyle(color: colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View Pro Benefits",
                              style: TextStyle(color: colorScheme.primary),
                            ),
                          ],
                        ),
                        onTap: () {
                          //TODO: Implement view pro benefits
                        },
                      ),
                    ],
                  ),
                ),
                // Section Appeariance
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.outlineVariant.withAlpha(150),
                      width: 1.5,
                    ),
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: AppBorderRadius.large,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Appearance",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Dark Mode", style: TextStyle(fontSize: 14)),
                              Text(
                                "Toggle dark mode theme",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.onSurface.withAlpha(140),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Switch(
                            value:
                                Theme.of(context).brightness == Brightness.dark,
                            onChanged: (value) {
                              //TODO: Implement theme change
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Section Notifications
                // Section Logout
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.outlineVariant.withAlpha(150),
                      width: 1.5,
                    ),
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: AppBorderRadius.large,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Actions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.medium,
                            side: BorderSide(
                              color: colorScheme.errorContainer,
                              width: 1,
                            ),
                          ),
                        ),
                        onPressed: () {
                          //TODO: Implement theme change
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_logout.svg',
                              colorFilter: ColorFilter.mode(
                                colorScheme.error,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Log Out",
                              style: TextStyle(color: colorScheme.error),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //version
                SizedBox(height: 8),
                Text(
                  "Version 1.0.0",
                  style: TextStyle(color: colorScheme.onSurface.withAlpha(140)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  final String id;
  final String email;
  final String username;
  final List<String> roles;
  final Geo geo;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.roles,
    required this.geo,
  });
}

class Geo {
  final String lat;
  final String long;

  Geo({required this.lat, required this.long});
}

final List<Map<String, String>> mockPlans = [
  {
    'title': 'Unlimited AI Chats',
    'description': 'Chat as much as you want with no limits',
  },
  {
    'title': 'Custom AI Bots',
    'description': 'Create unlimited custom bots for your needs',
  },
  {
    'title': 'Advanced Workflows',
    'description': 'Access to all workflow templates and automation',
  },
  {
    'title': 'Priority Support',
    'description': 'Get help faster with priority email support',
  },
  {
    'title': 'Early Access',
    'description': 'Try new features before everyone else',
  },
];
