import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
// import 'package:khtn_ai_final_project/data/models/user_models.dart';
import 'package:khtn_ai_final_project/core/constants/account_constants.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/auth/auth_view_model.dart';
import 'package:khtn_ai_final_project/presentation/views/account/widgets/logout_dialog.dart';
import 'package:khtn_ai_final_project/presentation/views/account/widgets/widgets.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/theme_provider.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/auth/user_view_model.dart';
import 'package:provider/provider.dart';

/// Account page - User profile and settings
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Delay to ensure context is available
    Future.microtask(() {
      final userVM = Provider.of<UserViewModel>(context, listen: false);
      userVM.loadCurrentUser();
    });
  }

  bool _showUpgradeBanner = true;
  bool isProUser = false;

  // User data will be provided by UserViewModel

  @override
  Widget build(BuildContext context) {
    final themeProvider = sl<ThemeProvider>();
    final user = context.watch<UserViewModel>().user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: AccountHeader(isProUser: isProUser, user: user),
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
    final authViewModel = sl<AuthViewModel>();
    final logoutResponse = await authViewModel.logout();

    if (!logoutResponse) {
      debugPrint("Logout failed");
    }
  }
}
