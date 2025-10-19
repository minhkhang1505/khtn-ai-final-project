import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/routes/app_routes.dart';
import 'package:khtn_ai_final_project/presentation/services/navigation_service.dart';

/// Home page of the application
///
/// Demonstrates various navigation methods and patterns
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildWelcomeCard(),
          const SizedBox(height: 24),
          _buildNavigationSection(),
          const SizedBox(height: 24),
          _buildActionsSection(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.waving_hand, size: 32, color: Colors.orange),
                const SizedBox(width: 12),
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'This is a demo of the navigation system. Try navigating to different pages using the buttons below.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            'Navigation Examples',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _NavigationButton(
          icon: Icons.login,
          title: 'Login Page',
          description: 'Navigate to login page',
          onTap: () => NavigationService.navigateTo(AppRoutes.login),
        ),
        const SizedBox(height: 12),
        _NavigationButton(
          icon: Icons.person_add,
          title: 'Register Page',
          description: 'Navigate to registration page',
          onTap: () => NavigationService.navigateTo(AppRoutes.register),
        ),
        const SizedBox(height: 12),
        _NavigationButton(
          icon: Icons.account_circle,
          title: 'Profile Page',
          description: 'Navigate to profile page',
          onTap: () => NavigationService.navigateTo(AppRoutes.profile),
        ),
        const SizedBox(height: 12),
        _NavigationButton(
          icon: Icons.settings,
          title: 'Settings Page',
          description: 'Navigate to settings page',
          onTap: () => NavigationService.navigateTo(AppRoutes.settings),
        ),
        const SizedBox(height: 12),
        _NavigationButton(
          icon: Icons.info,
          title: 'Details Page (with args)',
          description: 'Navigate with arguments',
          onTap: () => NavigationService.navigateTo(
            AppRoutes.details,
            arguments: {'id': '12345', 'title': 'Sample Item'},
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            'Navigation Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _NavigationButton(
          icon: Icons.check_circle,
          title: 'Show Success Message',
          description: 'Display a success snackbar',
          color: Colors.green,
          onTap: () => NavigationService.showSuccess('Operation successful!'),
        ),
        const SizedBox(height: 12),
        _NavigationButton(
          icon: Icons.error,
          title: 'Show Error Message',
          description: 'Display an error snackbar',
          color: Colors.red,
          onTap: () => NavigationService.showError('An error occurred!'),
        ),
        const SizedBox(height: 12),
        _NavigationButton(
          icon: Icons.warning,
          title: 'Show Warning Message',
          description: 'Display a warning snackbar',
          color: Colors.orange,
          onTap: () => NavigationService.showWarning('Warning: Please check!'),
        ),
        const SizedBox(height: 12),
        _NavigationButton(
          icon: Icons.info_outline,
          title: 'Show Info Message',
          description: 'Display an info snackbar',
          color: Colors.blue,
          onTap: () => NavigationService.showInfo('Information message'),
        ),
      ],
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color? color;

  const _NavigationButton({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (color ?? Theme.of(context).colorScheme.primary)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color ?? Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
