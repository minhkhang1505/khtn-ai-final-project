import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/views/account/models/account_models.dart';
import 'package:khtn_ai_final_project/presentation/views/account/models/account_constants.dart';
import 'package:khtn_ai_final_project/presentation/views/account/widgets/widgets.dart';

/// Account page - User profile and settings
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _showUpgradeBanner = true;

  final user = User(
    id: '1',
    email: 'user@example.com',
    username: 'Mockuser',
    roles: ['admin', 'user'],
    geo: Geo(lat: '40.7128', long: '-74.0060'),
  );

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: AccountHeader(user: user),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                if (_showUpgradeBanner)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: UpgradeBanner(
                      onDismiss: _dismissUpgradeBanner,
                      onTap: _showUpgradeDialog,
                    ),
                  ),
                SubscriptionSection(
                  currentPlan: freePlan,
                  onUpgradePressed: _showUpgradeDialog,
                ),
                const SizedBox(height: 16),
                AppearanceSection(
                  isDarkMode: isDarkMode,
                  onThemeChanged: _onThemeChanged,
                ),
                const SizedBox(height: 16),
                AccountActionsSection(onLogoutPressed: _onLogout),
                const SizedBox(height: 16),
                AccountFooter(version: appVersion),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dismissUpgradeBanner() {
    setState(() {
      _showUpgradeBanner = false;
    });
  }

  void _showUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) => UpgradeDialog(
        upgradePlan: proPlan,
        onUpgradeConfirmed: _onUpgradeConfirmed,
        onDismiss: () => Navigator.pop(context),
      ),
    );
  }

  void _onUpgradeConfirmed() {
    // TODO: Implement upgrade logic
    Navigator.pop(context);
  }

  void _onThemeChanged(bool value) {
    // TODO: Implement theme change
  }

  void _onLogout() {
    // TODO: Implement logout logic
  }
}
