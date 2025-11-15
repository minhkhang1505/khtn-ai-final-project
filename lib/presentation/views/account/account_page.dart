import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/data/models/account_models.dart';
import 'package:khtn_ai_final_project/core/constants/account_constants.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/auth_view_model.dart';
import 'package:khtn_ai_final_project/presentation/views/account/widgets/logout_dialog.dart';
import 'package:khtn_ai_final_project/presentation/views/account/widgets/widgets.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/theme_provider.dart';
import 'package:provider/provider.dart';

/// Account page - User profile and settings
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  bool _showUpgradeBanner = true;
  bool isProUser = false;

  final user = User(
    id: '1',
    email: 'user@example.com',
    username: 'Mockuser',
    roles: ['admin', 'user'],
    geo: Geo(lat: '40.7128', long: '-74.0060'),
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: AccountHeader(user: user, isProUser: isProUser),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWideScreen ? 800 : double.infinity,
              ),
              child: SafeArea(
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
                          currentPlan: proPlan,
                          onUpgradePressed: _showUpgradeDialog,
                          isProUser: isProUser,
                        ),
                        const SizedBox(height: AppSpacing.vertical + 4),
                        AppearanceSection(
                          isDarkMode: themeProvider.isDarkMode,
                          onThemeChanged: themeProvider.toggleTheme,
                        ),
                        const SizedBox(height: AppSpacing.vertical + 4),
                        //lout action
                        AccountActionsSection(
                          onLogoutPressed: () async {
                            final shouldLogout = await showDialog<bool>(
                              context: context,
                              builder: (_) => LogoutDialog(onLogout: _onLogout),
                            );

                            if (shouldLogout == true && context.mounted) {
                              Navigator.pushReplacementNamed(
                                context,
                                '/auth/login',
                              );
                            }
                          },
                        ),
                        const SizedBox(height: AppSpacing.vertical + 4),
                        AccountFooter(version: appVersion),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
    setState(() {
      _showUpgradeBanner = false;
      isProUser = true;
    });
  }

  Future<void> _onLogout() async {
    final authViewModel = context.read<AuthViewModel>();
    final logoutResponse = await authViewModel.logout();
    
    if (!logoutResponse) {
      debugPrint("Logout failed");
    }
  }
}
